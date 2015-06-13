//
//  UIButton.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

extension UIButton {
	public class func button(title title : String? = nil, backColor : UIColor? = nil, titleColor : UIColor? = nil, font : UIFont? = nil, cornerRadius : CGFloat? = nil) -> UIButton {
		let button = UIButton(type: .Custom)
		if let title = title { button.setTitle(title, forState: .Normal) }
		if let backColor = backColor { button.backgroundColor = backColor }
		if let titleColor = titleColor { button.setTitleColor(titleColor, forState: .Normal) }
		if let font = font { button.titleLabel?.font = font }
		
		if let cornerRadius = cornerRadius {
			button.layer.cornerRadius = cornerRadius
			button.layer.masksToBounds = true
		}
		
		return button
	}
}
