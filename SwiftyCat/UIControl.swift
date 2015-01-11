//
//  UIControl.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

extension UIControl {
	func addUpdateAction(target : AnyObject?, action : Selector) {
		addTarget(target, action: action, forControlEvents: .ValueChanged)
	}
	
	func addTouchAction(target : AnyObject?, action : Selector) {
		addTarget(target, action: action, forControlEvents: .TouchUpInside)
	}
}
