//
//  PurchaseManager.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 23/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation
import StoreKit

public enum PurchaseManagerNotification : String {
	case didPurchase = "cat.robo.SwiftyCat.PurchaseManagerDidPurchase"
	case didRestore = "cat.robo.SwiftyCat.PurchaseManagerDidRestore"
	
	public static let transactionIdKey = "PurchaseManagerNotification.transactionId"
	public static let dateKey = "PurchaseManagerNotification.date"
}

public enum PurchaseManagerError : Int {
	public static let errorDomain = "cat.robo.SwiftyCat.PurchaseManagerErrorDomain"
	
	case IAPUnavailable = 1001
	case ProductsNotLoaded = 1002
	
	public var errorValue : NSError {
		return NSError(domain: PurchaseManagerError.errorDomain, code: rawValue, userInfo: nil)
	}
}

public class PurchaseManager : NSObject {
	public enum PurchaseResult {
		case Cancelled
		case Failure(error : NSError)
		case Success(transactionId : String, date : NSDate)
	}
	
	public enum RestoreResult {
		case Cancelled
		case Failure(error : NSError)
		case Success
	}
	
	private(set) var products : [String:SKProduct] = [:]
	
	private var purchaseCompletion : (PurchaseResult -> Void)?
	private var restoreCompletion : (RestoreResult -> Void)?
	
	private lazy var priceFormatter : NSNumberFormatter = self.setupPriceFormatter()
	
	private func setupPriceFormatter() -> NSNumberFormatter {
		let formatter = NSNumberFormatter()
		formatter.formatterBehavior = .Behavior10_4
		formatter.numberStyle = .CurrencyStyle
		return formatter
	}
	
	public func loadProducts(productIds : [String]) {
		SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
		let request = SKProductsRequest(productIdentifiers: Set(productIds))
		request.delegate = self
		request.start()
	}
	
	public func priceOfProduct(productId : String) -> String? {
		if let product = products[productId] {
			priceFormatter.locale = product.priceLocale
			return priceFormatter.stringFromNumber(product.price)
		} else {
			return nil
		}
	}
	
	public func restorePurchases(completion : RestoreResult -> Void) {
		restoreCompletion = completion
		SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
	}
	
	public func purchaseProduct(productId : String, completion : PurchaseResult -> Void) {
		if !SKPaymentQueue.canMakePayments() {
			completion(.Failure(error: PurchaseManagerError.IAPUnavailable.errorValue))
		} else if let product = products[productId] {
			purchaseCompletion = completion
			SKPaymentQueue.defaultQueue().addPayment(SKPayment(product: product))
		} else {
			completion(.Failure(error: PurchaseManagerError.ProductsNotLoaded.errorValue))
		}
	}
	
	private func transactionIsPurchasing(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		
	}
	
	private func transactionIsDeferred(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		
	}
	
	private func transactionIsPurchased(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let transactionId = transaction.transactionIdentifier, transactionDate = transaction.transactionDate {
			purchaseCompletion?(.Success(transactionId: transactionId, date: transactionDate))
			purchaseCompletion = nil
			
			let info = [
				PurchaseManagerNotification.transactionIdKey: transactionId,
				PurchaseManagerNotification.dateKey: transactionDate,
			]
			
			NSNotificationCenter.postNotification(PurchaseManagerNotification.didPurchase.rawValue, from: self, info: info)
		}
		
		queue.finishTransaction(transaction)
	}
	
	private func transactionHasFailed(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let error = transaction.error {
			if error.code == SKErrorCode.PaymentCancelled.rawValue {
				purchaseCompletion?(.Cancelled)
			} else {
				purchaseCompletion?(.Failure(error: error))
			}
		} else {
			purchaseCompletion?(.Cancelled)
		}
		
		purchaseCompletion = nil
		queue.finishTransaction(transaction)
	}
	
	private func transactionIsRestored(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let transactionId = transaction.transactionIdentifier, transactionDate = transaction.transactionDate {
			purchaseCompletion?(.Success(transactionId: transactionId, date: transactionDate))
			purchaseCompletion = nil
			
			let info = [
				PurchaseManagerNotification.transactionIdKey: transactionId,
				PurchaseManagerNotification.dateKey: transactionDate,
			]
			
			NSNotificationCenter.postNotification(PurchaseManagerNotification.didRestore.rawValue, from: self, info: info)
		}
		
		queue.finishTransaction(transaction)
	}
}

extension PurchaseManager : SKPaymentTransactionObserver {
	public func paymentQueue(queue : SKPaymentQueue, updatedTransactions transactions : [SKPaymentTransaction]) {
		for transaction in transactions {
			switch transaction.transactionState {
			case .Purchasing: transactionIsPurchasing(transaction, queue: queue)
			case .Deferred: transactionIsDeferred(transaction, queue: queue)
			case .Purchased: transactionIsPurchased(transaction, queue: queue)
			case .Failed: transactionHasFailed(transaction, queue: queue)
			case .Restored: transactionIsRestored(transaction, queue: queue)
			}
		}
	}
	
	public func paymentQueue(queue : SKPaymentQueue, restoreCompletedTransactionsFailedWithError error : NSError) {
		restoreCompletion?(.Failure(error: error))
	}
	
	public func paymentQueueRestoreCompletedTransactionsFinished(queue : SKPaymentQueue) {
		restoreCompletion?(.Success)
	}
}

extension PurchaseManager : SKProductsRequestDelegate {
	public func productsRequest(request : SKProductsRequest, didReceiveResponse response : SKProductsResponse) {
		if response.invalidProductIdentifiers.count > 0 {
			print("Invalid product indentififers: \(response.invalidProductIdentifiers)")
		}
		
		for product in response.products {
			products[product.productIdentifier] = product
		}
	}
}
