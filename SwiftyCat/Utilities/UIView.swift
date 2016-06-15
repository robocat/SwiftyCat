//
//  UIView.swift
//  SwiftyCat
//
//  Created by Simon Støvring on 25/08/2015.
//  Copyright © 2015 Robocat. All rights reserved.
//

import Foundation

public extension UIView {
    public func addSubviews(_ views: [UIView]) {
        for v in views {
            addSubview(v)
        }
    }
    
    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
}
