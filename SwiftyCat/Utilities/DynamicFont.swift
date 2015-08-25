//
//  DynamicFont.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 24/06/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

@available(iOS 9, *)
public enum DynamicFont {
	case Title1
	case Title2
	case Title3
	case Headline
	case Subheadline
	case Body
	case Callout
	case Footnote
	case Caption1
	case Caption2
	
	private var stringValue : String {
		switch self {
		case .Title1: return UIFontTextStyleTitle1
		case .Title2: return UIFontTextStyleTitle2
		case .Title3: return UIFontTextStyleTitle3
		case .Headline: return UIFontTextStyleHeadline
		case .Subheadline: return UIFontTextStyleSubheadline
		case .Body: return UIFontTextStyleBody
		case .Callout: return UIFontTextStyleCallout
		case .Footnote: return UIFontTextStyleFootnote
		case .Caption1: return UIFontTextStyleCaption1
		case .Caption2: return UIFontTextStyleCaption2
		}
	}
}

@available(iOS 9, *)
public extension UILabel {
	public func setDynamicFont(textStyle : DynamicFont) {
		font = UIFont.preferredFontForTextStyle(textStyle.stringValue)
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: .mainQueue()) { [weak self] notification in
			self?.setDynamicFont(textStyle)
		}
	}
}

@available(iOS 9, *)
public extension UITextView {
	public func setDynamicFont(textStyle : DynamicFont) {
		font = UIFont.preferredFontForTextStyle(textStyle.stringValue)
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: .mainQueue()) { [weak self] notification in
			self?.setDynamicFont(textStyle)
		}
	}
}

@available(iOS 9, *)
public extension UIButton {
	public func setDynamicFont(textStyle : DynamicFont) {
		titleLabel?.setDynamicFont(textStyle)
	}
}
