//
//  ForbindExtensions.swift
//  Thermo2
//
//  Created by Ulrik Damm on 24/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import Foundation
import Forbind

public func handleError<T>(onError: NSError -> Void)(_ result: Result<T>) -> T? {
	switch result {
	case .Error(let error):
		onError(error)
		return nil
	case .Ok(let value):
		return value
	}
}

public func ignoreError<T>(result: Result<T>) -> T? {
	return handleError({ _ in })(result)
}

public func pause<T>(time: NSTimeInterval)(value: Result<T>) -> Promise<Result<T>> {
	let promise = Promise<Result<T>>()
	
	dispatch_after(Double(time)) {
		promise.setValue(value)
	}
	
	return promise
}

public func dispatch<T>(queue: dispatch_queue_t)(value: Result<T>) -> Promise<Result<T>> {
	let promise = Promise<Result<T>>()
	
	dispatch_async(queue) {
		promise.setValue(value)
	}
	
	return promise
}
