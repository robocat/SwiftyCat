//
//  AutolayoutExtensions.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

extension UIView {
	public func constraints(vertical: String? = nil, horizontal: String? = nil, _ views: [String : UIView]) -> [NSLayoutConstraint] {
		var constraints: [NSLayoutConstraint] = []
		
		if let v = vertical {
			constraints += addConstraintsWithFormat("V:\(v)", views: views) as [NSLayoutConstraint]
		}
		
		if let h = horizontal {
			constraints += addConstraintsWithFormat("H:\(h)", views: views) as [NSLayoutConstraint]
		}
		
		for (_, view) in views {
			view.setTranslatesAutoresizingMaskIntoConstraints(false)
		}
		
		return constraints
	}
	
	public func constraint(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UIView? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
		item.setTranslatesAutoresizingMaskIntoConstraints(false)
		item2?.setTranslatesAutoresizingMaskIntoConstraints(false)
		return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    public func constraint(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UILayoutSupport, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.setTranslatesAutoresizingMaskIntoConstraints(false)
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    private func constraintUsing(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relation, toItem: item2, attribute: attribute2, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
	
	public func addSubviews(subviews : UIView...) {
		for view in subviews {
			addSubview(view)
		}
	}
	
	public func addSubviews(subviews : [UIView]) {
		for view in subviews {
			addSubview(view)
		}
	}
	
	public func addConstraintsWithFormat(format: String, views: [String: UIView]) -> [NSLayoutConstraint] {
		let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: nil, metrics: nil, views: views)
		addConstraints(constraints)
		
		return constraints as [NSLayoutConstraint]
	}
	
	public func setTopSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
		return constraint(self, .Top, .Equal, superview, .Top, constant: space)
	}
	
	public func setBottomSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
		return constraint(self, .Top, .Equal, superview, .Bottom, constant: space)
	}
	
	public func setLeadingSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
		return constraint(self, .Leading, .Equal, superview, .Leading, constant: space)
	}
	
	public func setTrailingSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
		return constraint(self, .Trailing, .Equal, superview, .Trailing, constant: space)
	}
	
	public func setWidthEqualToSuperView() -> NSLayoutConstraint {
		return constraint(self, .Width, .Equal, superview, .Width)
	}
}
