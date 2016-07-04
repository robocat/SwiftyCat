//
//  UIViewAnimation.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

public extension UIView {
	public class func animate(duration duration : NSTimeInterval = 0.3, delay : NSTimeInterval = 0, springDamping : CGFloat? = nil, springVelocity : CGFloat? = nil, options : UIViewAnimationOptions = [], animations : Void -> Void, completion : (Void -> Void)?) {
		if springDamping != nil || springVelocity != nil {
			UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: springDamping ?? 0, initialSpringVelocity: springVelocity ?? 0, options: options, animations: animations, completion: { _ in completion?(); return })
		} else {
			UIView.animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: { _ in completion?(); return })
		}
	}
	
	public class func animate(duration duration : NSTimeInterval = 0.3, delay : NSTimeInterval = 0, springDamping : CGFloat? = nil, springVelocity : CGFloat? = nil, options : UIViewAnimationOptions = [], animations : Void -> Void) {
		if springDamping != nil || springVelocity != nil {
			UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: springDamping ?? 0, initialSpringVelocity: springVelocity ?? 0, options: options, animations: animations, completion: nil)
		} else {
			UIView.animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: nil)
		}
	}
}
