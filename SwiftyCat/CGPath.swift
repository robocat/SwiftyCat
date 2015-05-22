//
//  CGPath.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 22/05/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import CoreGraphics

extension CGPath {
	static func mutablePath() -> CGMutablePath {
		return CGPathCreateMutable()
	}
	
	static func pathWithRect(rect : CGRect) -> CGPath {
		return CGPathCreateWithRect(rect, nil)
	}
	
	static func pathWithEllipse(inRect rect : CGRect) -> CGPath {
		return CGPathCreateWithEllipseInRect(rect, nil)
	}
	
	static func pathWithRoundedRect(rect : CGRect, cornerSize : CGSize) -> CGPath {
		return CGPathCreateWithRoundedRect(rect, cornerSize.width, cornerSize.height, nil)
	}
	
	func mutableCopy() -> CGMutablePath {
		return CGPathCreateMutableCopy(self)
	}
	
	func containsPoint(point : CGPoint) -> Bool {
		return CGPathContainsPoint(self, nil, point, false)
	}
	
	func boundingBox() -> CGRect {
		return CGPathGetPathBoundingBox(self)
	}
	
	var currentPoint : CGPoint {
		return CGPathGetCurrentPoint(self)
	}
}

extension CGMutablePath {
	func moveToPoint(point : CGPoint) {
		CGPathMoveToPoint(self, nil, point.x, point.y)
	}
	
	func moveToPoint(x : CGFloat, y : CGFloat) {
		CGPathMoveToPoint(self, nil, x, y)
	}
	
	func addLineToPoint(point : CGPoint) {
		CGPathAddLineToPoint(self, nil, point.x, point.y)
	}
	
	func addLineToPoint(x : CGFloat, y : CGFloat) {
		CGPathAddLineToPoint(self, nil, x, y)
	}
	
	func closeSubpath() {
		CGPathCloseSubpath(self)
	}
}
