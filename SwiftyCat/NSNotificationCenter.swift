//
//  NSNotificationCenter.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 23/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
	class func postNotification(name : String, from : AnyObject?, info : [String: AnyObject]? = nil) {
		NSNotificationCenter.defaultCenter().postNotificationName(name, object: from, userInfo: info)
	}
}

extension NSNotification {
	subscript(key : String) -> AnyObject? {
		return userInfo?[key]
	}
}
