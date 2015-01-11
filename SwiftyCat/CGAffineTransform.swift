//
//  CGAffineTransform.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import CoreGraphics

extension CGAffineTransform {
	init() {
		self = CGAffineTransformIdentity
	}
	
	static var identity : CGAffineTransform {
		return CGAffineTransformIdentity
	}
	
	func translate(#x : CGFloat, y : CGFloat) -> CGAffineTransform {
		return CGAffineTransformTranslate(self, x, y)
	}
	
	func rotate(angle : Double) -> CGAffineTransform {
		return CGAffineTransformRotate(self, CGFloat(angle))
	}
	
	func scale(#x : CGFloat, y : CGFloat) -> CGAffineTransform {
		return CGAffineTransformScale(self, x, y)
	}
	
	func scale(scale : CGFloat) -> CGAffineTransform {
		return CGAffineTransformScale(self, scale, scale)
	}
}
