//
//  CGPath.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 22/05/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import CoreGraphics

extension CGPath {
	public static func pathWithRect(rect : CGRect) -> CGPath {
		return CGPathCreateWithRect(rect, nil)
	}
	
	public static func pathWithEllipse(inRect rect : CGRect) -> CGPath {
		return CGPathCreateWithEllipseInRect(rect, nil)
	}
	
	public static func pathWithRoundedRect(rect : CGRect, cornerSize : CGSize) -> CGPath {
		return CGPathCreateWithRoundedRect(rect, cornerSize.width, cornerSize.height, nil)
	}
	
	public func mutableCopy() -> CGMutablePath {
		return CGPathCreateMutableCopy(self)
	}
	
	public func containsPoint(point : CGPoint) -> Bool {
		return CGPathContainsPoint(self, nil, point, false)
	}
	
	public func boundingBox() -> CGRect {
		return CGPathGetPathBoundingBox(self)
	}
	
	public var currentPoint : CGPoint {
		return CGPathGetCurrentPoint(self)
	}
}

extension CGMutablePath {
	public static func mutablePath() -> CGMutablePath {
		return CGPathCreateMutable()
	}
	
	public func moveToPoint(point : CGPoint) {
		CGPathMoveToPoint(self, nil, point.x, point.y)
	}
	
	public func moveToPoint(#x : CGFloat, y : CGFloat) {
		CGPathMoveToPoint(self, nil, x, y)
	}
	
	public func addLineToPoint(point : CGPoint) {
		CGPathAddLineToPoint(self, nil, point.x, point.y)
	}
	
	public func addLineToPoint(#x : CGFloat, y : CGFloat) {
		CGPathAddLineToPoint(self, nil, x, y)
	}
	
	public func closeSubpath() {
		CGPathCloseSubpath(self)
	}
}
