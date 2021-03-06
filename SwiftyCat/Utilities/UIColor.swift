//
//  UIColor.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public extension UIColor {
	public convenience init(hex : UInt32, alpha : CGFloat = 1) {
		let red = CGFloat((hex & 0x00ff0000) >> 16) / CGFloat(0xff)
		let green = CGFloat((hex & 0x0000ff00) >> 8) / CGFloat(0xff)
		let blue = CGFloat((hex & 0x000000ff) >> 0) / CGFloat(0xff)
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}
