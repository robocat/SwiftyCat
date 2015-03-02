//
//  UIControl.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

extension UIControl {
	public func addUpdateAction(target : AnyObject?,  _nonnull action : Selector) {
		addTarget(target, action: action, forControlEvents: .ValueChanged)
	}
	
	public func addTouchAction(target : AnyObject?,  _nonnull action : Selector) {
		addTarget(target, action: action, forControlEvents: .TouchUpInside)
	}
}
