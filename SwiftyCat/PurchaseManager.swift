//
//  PurchaseManager.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 23/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation
import StoreKit

enum PurchaseManagerNotification : String {
	case didPurchase = "cat.robo.SwiftyCat.PurchaseManagerDidPurchase"
	case didRestore = "cat.robo.SwiftyCat.PurchaseManagerDidRestore"
	
	static let transactionIdKey = "PurchaseManagerNotification.transactionId"
	static let dateKey = "PurchaseManagerNotification.date"
}

enum PurchaseManagerError : Int {
	static let errorDomain = "cat.robo.SwiftyCat.PurchaseManagerErrorDomain"
	
	case IAPUnavailable = 1001
	case ProductsNotLoaded = 1002
	
	var errorValue : NSError {
		return NSError(domain: PurchaseManagerError.errorDomain, code: rawValue, userInfo: nil)
	}
}

class PurchaseManager : NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
	enum PurchaseResult {
		case Cancelled
		case Failure(error : NSError)
		case Success(transactionId : String, date : NSDate)
	}
	
	enum RestoreResult {
		case Cancelled
		case Failure(error : NSError)
		case Success
	}
	
	private(set) var products : [String:SKProduct] = [:]
	
	private var purchaseCompletion : (PurchaseResult -> Void)?
	private var restoreCompletion : (RestoreResult -> Void)?
	
	private lazy var priceFormatter : NSNumberFormatter = self.setupPriceFormatter()
	
	func setupPriceFormatter() -> NSNumberFormatter {
		let formatter = NSNumberFormatter()
		formatter.formatterBehavior = .Behavior10_4
		formatter.numberStyle = .CurrencyStyle
		return formatter
	}
	
	func loadProducts(productIds : [String]) {
		SKPaymentQueue.defaultQueue().addTransactionObserver(self)
		
		let request = SKProductsRequest(productIdentifiers: NSSet(array: productIds))
		request.delegate = self
		request.start()
	}
	
	func priceOfProduct(productId : String) -> String? {
		if let product = products[productId] {
			priceFormatter.locale = product.priceLocale
			return priceFormatter.stringFromNumber(product.price)
		} else {
			return nil
		}
	}
	
	func restorePurchases(completion : RestoreResult -> Void) {
		restoreCompletion = completion
		SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
	}
	
	func purchaseProduct(productId : String, completion : PurchaseResult -> Void) {
		if !SKPaymentQueue.canMakePayments() {
			completion(.Failure(error: PurchaseManagerError.IAPUnavailable.errorValue))
		} else if let product = products[productId] {
			purchaseCompletion = completion
			SKPaymentQueue.defaultQueue().addPayment(SKPayment(product: product))
		} else {
			completion(.Failure(error: PurchaseManagerError.ProductsNotLoaded.errorValue))
		}
	}
	
	func transactionIsPurchasing(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		
	}
	
	func transactionIsDeferred(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		
	}
	
	func transactionIsPurchased(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		purchaseCompletion?(.Success(transactionId: transaction.transactionIdentifier, date: transaction.transactionDate))
		purchaseCompletion = nil
		
		let info = [
			PurchaseManagerNotification.transactionIdKey: transaction.transactionIdentifier,
			PurchaseManagerNotification.dateKey: transaction.transactionDate,
		]
		
		NSNotificationCenter.postNotification(PurchaseManagerNotification.didPurchase.rawValue, from: self, info: info)
		
		queue.finishTransaction(transaction)
	}
	
	func transactionHasFailed(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		if let error = transaction.error {
			if error.code == SKErrorPaymentCancelled {
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
	
	func transactionIsRestored(transaction : SKPaymentTransaction, queue : SKPaymentQueue) {
		let info = [
			PurchaseManagerNotification.transactionIdKey: transaction.transactionIdentifier,
			PurchaseManagerNotification.dateKey: transaction.transactionDate,
		]
		
		NSNotificationCenter.postNotification(PurchaseManagerNotification.didRestore.rawValue, from: self, info: info)
		
		purchaseCompletion?(.Success(transactionId: transaction.transactionIdentifier, date: transaction.transactionDate))
		purchaseCompletion = nil
		
		queue.finishTransaction(transaction)
	}
	
	// MARK: SKPaymentTransactionObserver
	
	func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
		for transaction in transactions as [SKPaymentTransaction] {
			switch transaction.transactionState {
			case .Purchasing: transactionIsPurchasing(transaction, queue: queue)
			case .Deferred: transactionIsDeferred(transaction, queue: queue)
			case .Purchased: transactionIsPurchased(transaction, queue: queue)
			case .Failed: transactionHasFailed(transaction, queue: queue)
			case .Restored: transactionIsRestored(transaction, queue: queue)
			}
		}
	}
	
	func paymentQueue(queue: SKPaymentQueue!, restoreCompletedTransactionsFailedWithError error: NSError!) {
		restoreCompletion?(.Failure(error: error))
	}
	
	func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
		restoreCompletion?(.Success)
	}
	
	// MARK: SKProductsRequestDelegate
	
	func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
		if response.invalidProductIdentifiers.count > 0 {
			println("Invalid product indentififers: \(response.invalidProductIdentifiers)")
		}
		
		for product in response.products as [SKProduct] {
			products[product.productIdentifier] = product
		}
	}
}

