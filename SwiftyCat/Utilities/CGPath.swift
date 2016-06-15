//
//  CGPath.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 22/05/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import CoreGraphics

extension CGPath {
	public static func pathWithRect(_ rect : CGRect) -> CGPath {
		return CGPath(rect: rect, transform: nil)
	}
	
	public static func pathWithEllipse(inRect rect : CGRect) -> CGPath {
		return CGPath(ellipseIn: rect, transform: nil)
	}
	
	public static func pathWithRoundedRect(_ rect : CGRect, cornerSize : CGSize) -> CGPath {
		return CGPath(roundedRect: rect, cornerWidth: cornerSize.width, cornerHeight: cornerSize.height, transform: nil)
	}
	
	public func mutableCopy() -> CGMutablePath {
		return self.mutableCopy()!
	}
	
	public func containsPoint(_ point : CGPoint) -> Bool {
		return self.containsPoint(nil, point: point, eoFill: false)
	}
	
	public func boundingBox() -> CGRect {
		return self.boundingBoxOfPath
	}
	
	public var currentPoint : CGPoint {
		return self.currentPoint
	}
}

extension CGMutablePath {
	public static func mutablePath() -> CGMutablePath {
		return CGMutablePath()
	}
	
	public func moveToPoint(_ point : CGPoint) {
		self.moveTo(nil, x: point.x, y: point.y)
	}
	
	public func moveToPoint(x : CGFloat, y : CGFloat) {
		self.moveTo(nil, x: x, y: y)
	}
	
	public func addLineToPoint(_ point : CGPoint) {
		self.addLineTo(nil, x: point.x, y: point.y)
	}
	
	public func addLineToPoint(x : CGFloat, y : CGFloat) {
		self.addLineTo(nil, x: x, y: y)
	}
	
	public func closeSubpath() {
		self.closeSubpath()
	}
}
