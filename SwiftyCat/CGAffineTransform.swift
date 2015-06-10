//
//  CGAffineTransform.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import CoreGraphics

extension CGAffineTransform {
	public init() {
		self = CGAffineTransformIdentity
	}
	
	public static var identity : CGAffineTransform {
		return CGAffineTransformIdentity
	}
	
	public func translate(x x : CGFloat, y : CGFloat) -> CGAffineTransform {
		return CGAffineTransformTranslate(self, x, y)
	}
	
	public func rotate(angle : Double) -> CGAffineTransform {
		return CGAffineTransformRotate(self, CGFloat(angle))
	}
	
	public func scale(x x : CGFloat, y : CGFloat) -> CGAffineTransform {
		return CGAffineTransformScale(self, x, y)
	}
	
	public func scale(scale : CGFloat) -> CGAffineTransform {
		return CGAffineTransformScale(self, scale, scale)
	}
}
