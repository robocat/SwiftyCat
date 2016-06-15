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
		self = CGAffineTransform.identity
	}
	
	public static var identity : CGAffineTransform {
		return CGAffineTransform.identity
	}
	
	public func translate(x : CGFloat, y : CGFloat) -> CGAffineTransform {
		return self.translateBy(x: x, y: y)
	}
	
	public func rotate(_ angle : Double) -> CGAffineTransform {
		return self.rotate(CGFloat(angle))
	}
	
	public func scale(x : CGFloat, y : CGFloat) -> CGAffineTransform {
		return self.scaleBy(x: x, y: y)
	}
	
	public func scale(_ scale : CGFloat) -> CGAffineTransform {
		return self.scaleBy(x: scale, y: scale)
	}
}
