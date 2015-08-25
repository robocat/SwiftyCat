//
//  UIImage.swift
//  SwiftyCat
//
//  Created by Simon Støvring on 25/08/2015.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public extension UIImage {
    public class func clearImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public class func imageWithColor(color : UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        color.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func resized(to size : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        drawInRect(CGRect(origin: CGPointZero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func masked(with mask : UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        let rect = CGRect(origin: CGPointZero, size: size)
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage)
        drawInRect(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
