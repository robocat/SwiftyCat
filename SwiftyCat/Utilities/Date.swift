//
//  Date.swift
//  SwiftyCat
//
//  Created by Simon Støvring on 26/08/2015.
//  Copyright © 2015 Robocat. All rights reserved.
//

import Foundation

public func minutes(timeInterval : NSTimeInterval) -> NSTimeInterval {
    return timeInterval * 60
}

public func hours(timeInterval : NSTimeInterval) -> NSTimeInterval {
    return minutes(timeInterval) * 60
}

public func days(timeInterval : NSTimeInterval) -> NSTimeInterval {
    return hours(timeInterval) * 24
}
