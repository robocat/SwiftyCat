//
//  NSNotificationCenter.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 23/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation

public extension NSNotificationCenter {
	public class func postNotification(name : String, from : AnyObject?, info : [String: AnyObject]? = nil) {
		NSNotificationCenter.defaultCenter().postNotificationName(name, object: from, userInfo: info)
	}
    
    public class func on(notification : String, on : AnyObject? = nil, doThis : NSNotification -> Void) {
        defaultCenter().addObserverForName(notification, object: on, queue: nil, usingBlock: doThis)
    }
}

extension NSNotification {
	subscript(key : String) -> AnyObject? {
		return userInfo?[key]
	}
}
