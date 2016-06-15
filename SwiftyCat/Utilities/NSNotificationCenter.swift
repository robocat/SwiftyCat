//
//  NSNotificationCenter.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 23/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation

public extension NotificationCenter {
	public class func postNotification(_ name : String, from : AnyObject?, info : [String: AnyObject]? = nil) {
		NotificationCenter.default().post(name: Notification.Name(rawValue: name), object: from, userInfo: info)
	}
    
    public class func on(_ notification : String, on : AnyObject? = nil, doThis : (Notification) -> Void) {
        `default`().addObserver(forName: NSNotification.Name(rawValue: notification), object: on, queue: nil, using: doThis)
    }
}

extension Notification {
	subscript(key : String) -> AnyObject? {
		return userInfo?[key] as? AnyObject
	}
}
