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
	
	case iapUnavailable = 1001
	case productsNotLoaded = 1002
	
	public var errorValue : NSError {
		return NSError(domain: PurchaseManagerError.errorDomain, code: rawValue, userInfo: nil)
	}
}

public class PurchaseManager : NSObject {
	public enum PurchaseResult {
		case cancelled
		case failure(error : NSError)
		case success(transactionId : String, date : Date)
	}
	
	public enum RestoreResult {
		case cancelled
		case failure(error : NSError)
		case success
	}
	
	private(set) var products : [String:SKProduct] = [:]
	
	private var purchaseCompletion : ((PurchaseResult) -> Void)?
	private var restoreCompletion : ((RestoreResult) -> Void)?
	
	private lazy var priceFormatter : NumberFormatter = self.setupPriceFormatter()
	
	private func setupPriceFormatter() -> NumberFormatter {
		let formatter = NumberFormatter()
		formatter.formatterBehavior = .behavior10_4
		formatter.numberStyle = .currency
		return formatter
	}
	
	public func loadProducts(_ productIds : [String]) {
		SKPaymentQueue.default().add(self)
        
		let request = SKProductsRequest(productIdentifiers: Set(productIds))
		request.delegate = self
		request.start()
	}
	
	public func priceOfProduct(_ productId : String) -> String? {
		if let product = products[productId] {
			priceFormatter.locale = product.priceLocale
			return priceFormatter.string(from: product.price)
		} else {
			return nil
		}
	}
	
	public func restorePurchases(_ completion : (RestoreResult) -> Void) {
		restoreCompletion = completion
		SKPaymentQueue.default().restoreCompletedTransactions()
	}
	
	public func purchaseProduct(_ productId : String, completion : (PurchaseResult) -> Void) {
		if !SKPaymentQueue.canMakePayments() {
			completion(.failure(error: PurchaseManagerError.iapUnavailable.errorValue))
		} else if let product = products[productId] {
			purchaseCompletion = completion
			SKPaymentQueue.default().add(SKPayment(product: product))
		} else {
			completion(.failure(error: PurchaseManagerError.productsNotLoaded.errorValue))
		}
	}
	
	private func transactionIsPurchasing(_ transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		
	}
	
	private func transactionIsDeferred(_ transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		
	}
	
	private func transactionIsPurchased(_ transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let transactionId = transaction.transactionIdentifier, transactionDate = transaction.transactionDate {
			purchaseCompletion?(.success(transactionId: transactionId, date: transactionDate))
			purchaseCompletion = nil
			
			let info : [String: AnyObject] = [
				PurchaseManagerNotification.transactionIdKey: transactionId,
				PurchaseManagerNotification.dateKey: transactionDate,
			]
			
			NotificationCenter.postNotification(PurchaseManagerNotification.didPurchase.rawValue, from: self, info: info)
		}
		
		queue.finishTransaction(transaction)
	}
	
	private func transactionHasFailed(_ transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let error = transaction.error {
			if error.code == SKErrorCode.paymentCancelled.rawValue {
				purchaseCompletion?(.cancelled)
			} else {
				purchaseCompletion?(.failure(error: error))
			}
		} else {
			purchaseCompletion?(.cancelled)
		}
		
		purchaseCompletion = nil
		queue.finishTransaction(transaction)
	}
	
	private func transactionIsRestored(_ transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let transactionId = transaction.transactionIdentifier, transactionDate = transaction.transactionDate {
			purchaseCompletion?(.success(transactionId: transactionId, date: transactionDate))
			purchaseCompletion = nil
			
			let info : [String: AnyObject] = [
				PurchaseManagerNotification.transactionIdKey: transactionId,
				PurchaseManagerNotification.dateKey: transactionDate,
			]
			
			NotificationCenter.postNotification(PurchaseManagerNotification.didRestore.rawValue, from: self, info: info)
		}
		
		queue.finishTransaction(transaction)
	}
}

extension PurchaseManager : SKPaymentTransactionObserver {
	public func paymentQueue(_ queue : SKPaymentQueue, updatedTransactions transactions : [SKPaymentTransaction]) {
		for transaction in transactions {
			switch transaction.transactionState {
			case .purchasing: transactionIsPurchasing(transaction, queue: queue)
			case .deferred: transactionIsDeferred(transaction, queue: queue)
			case .purchased: transactionIsPurchased(transaction, queue: queue)
			case .failed: transactionHasFailed(transaction, queue: queue)
			case .restored: transactionIsRestored(transaction, queue: queue)
			}
		}
	}
	
	public func paymentQueue(_ queue : SKPaymentQueue, restoreCompletedTransactionsFailedWithError error : NSError) {
		restoreCompletion?(.failure(error: error))
	}
	
	public func paymentQueueRestoreCompletedTransactionsFinished(_ queue : SKPaymentQueue) {
		restoreCompletion?(.success)
	}
}

extension PurchaseManager : SKProductsRequestDelegate {
	public func productsRequest(_ request : SKProductsRequest, didReceive response : SKProductsResponse) {
		if response.invalidProductIdentifiers.count > 0 {
			print("Invalid product indentififers: \(response.invalidProductIdentifiers)")
		}
		
		for product in response.products {
			products[product.productIdentifier] = product
		}
	}
}
