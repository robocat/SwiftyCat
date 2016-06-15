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
	case title1
	case title2
	case title3
	case headline
	case subheadline
	case body
	case callout
	case footnote
	case caption1
	case caption2
	
	private var stringValue : String {
		switch self {
		case .title1: return UIFontTextStyleTitle1
		case .title2: return UIFontTextStyleTitle2
		case .title3: return UIFontTextStyleTitle3
		case .headline: return UIFontTextStyleHeadline
		case .subheadline: return UIFontTextStyleSubheadline
		case .body: return UIFontTextStyleBody
		case .callout: return UIFontTextStyleCallout
		case .footnote: return UIFontTextStyleFootnote
		case .caption1: return UIFontTextStyleCaption1
		case .caption2: return UIFontTextStyleCaption2
		}
	}
}

@available(iOS 9, *)
public extension UILabel {
	public func setDynamicFont(_ textStyle : DynamicFont) {
		font = UIFont.preferredFont(forTextStyle: textStyle.stringValue)
		
		NotificationCenter.default().removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
		NotificationCenter.default().addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: .main()) { [weak self] notification in
			self?.setDynamicFont(textStyle)
		}
	}
}

@available(iOS 9, *)
public extension UITextView {
	public func setDynamicFont(_ textStyle : DynamicFont) {
		font = UIFont.preferredFont(forTextStyle: textStyle.stringValue)
		
		NotificationCenter.default().removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
		NotificationCenter.default().addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: .main()) { [weak self] notification in
			self?.setDynamicFont(textStyle)
		}
	}
}

@available(iOS 9, *)
public extension UIButton {
	public func setDynamicFont(_ textStyle : DynamicFont) {
		titleLabel?.setDynamicFont(textStyle)
	}
}
