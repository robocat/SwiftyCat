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
            constraints += addConstraintsWithFormat("V:\(v)", views: views)
		}
		
		if let h = horizontal {
			constraints += addConstraintsWithFormat("H:\(h)", views: views)
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
    
    public func constraintToLayoutSupport(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UILayoutSupport, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.setTranslatesAutoresizingMaskIntoConstraints(false)
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    private func constraintUsing(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        let constraint = makeConstraint(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    private func makeConstraint(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relation, toItem: item2, attribute: attribute2, multiplier: multiplier, constant: constant)
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
		
		return constraints as NSArray as! [NSLayoutConstraint]
	}
	
	public func setTopSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
        let theConstraint = makeConstraint(self, .Top, .Equal, superview, .Top, constant: space)
        superview!.addConstraint(theConstraint)
        return theConstraint
	}
	
	public func setBottomSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
        let theConstraint = makeConstraint(self, .Bottom, .Equal, superview, .Bottom, constant: space)
        superview!.addConstraint(theConstraint)
        return theConstraint
	}
	
	public func setLeadingSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
        let theConstraint = makeConstraint(self, .Leading, .Equal, superview, .Leading, constant: space)
        superview!.addConstraint(theConstraint)
        return theConstraint
	}
	
	public func setTrailingSpaceToSuperView(space: CGFloat) -> NSLayoutConstraint {
        let theConstraint = makeConstraint(self, .Trailing, .Equal, superview, .Trailing, constant: space)
        superview!.addConstraint(theConstraint)
        return theConstraint
	}
	
	public func setWidthEqualToSuperView() -> NSLayoutConstraint {
		return constraint(self, .Width, .Equal, superview, .Width)
	}
    
    public func setWidthEqual(width: CGFloat) -> NSLayoutConstraint {
        return constraint(self, .Width, .Equal, constant: width)
    }
    
    public func setHeightEqual(height: CGFloat) -> NSLayoutConstraint {
        return constraint(self, .Height, .Equal, constant: height)
    }
    
    public func centerXInSuperView(offset: CGFloat = 0) -> NSLayoutConstraint {
        let theConstraint = makeConstraint(self, .CenterX, .Equal, superview, .CenterX, constant: offset)
        superview?.addConstraint(theConstraint)
        return theConstraint
    }
    
    public func centerYInSuperView(offset: CGFloat = 0) -> NSLayoutConstraint {
        let theConstraint = makeConstraint(self, .CenterY, .Equal, superview, .CenterY, constant: offset)
        superview?.addConstraint(theConstraint)
        return theConstraint
    }
    
    public func centerInSuperView(offset: CGPoint = CGPointZero) -> [NSLayoutConstraint] {
        return [ centerXInSuperView(offset: offset.x), centerYInSuperView(offset: offset.y) ]
    }
    
    public func edgesEqualsSuperView(inset: UIEdgeInsets = UIEdgeInsetsZero) {
        superview?.constraints(
            vertical: "|-\(inset.top)-[view]-\(inset.bottom)-|",
            horizontal: "|-\(inset.left)-[view]-\(inset.right)-|",
            [ "view": self ])
    }
    
}

public extension UIViewController {
    
    public func alignViewToTopLayoutGuide(view: UIView, viewAttribute: NSLayoutAttribute = .Top, space: CGFloat = 0, layoutGuideAttribute: NSLayoutAttribute = .Bottom) -> NSLayoutConstraint {
        return view.superview!.constraintToLayoutSupport(view, viewAttribute, .Equal, topLayoutGuide, layoutGuideAttribute, constant: space)
    }
    
    public func alignViewToBottomLayoutGuide(view: UIView, viewAttribute: NSLayoutAttribute = .Bottom, space: CGFloat = 0, layoutGuideAttribute: NSLayoutAttribute = .Top) -> NSLayoutConstraint {
        return view.superview!.constraintToLayoutSupport(view, viewAttribute, .Equal, bottomLayoutGuide, layoutGuideAttribute, constant: space)
    }
    
}
