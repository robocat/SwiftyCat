//
//  UILabel.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

public extension UILabel {
	public convenience init(text : String? = nil, color : UIColor? = nil, font : UIFont? = nil, alignment : NSTextAlignment? = nil, breakLines : Bool = false) {
		self.init(frame: CGRectZero)
		if let text = text { self.text = text }
		if let color = color { textColor = color }
		if let font = font { self.font = font }
		if let alignment = alignment { self.textAlignment = alignment }
		
		if breakLines {
			numberOfLines = 0
		} else {
			numberOfLines = 1
			adjustsFontSizeToFitWidth = true
		}
	}
}
