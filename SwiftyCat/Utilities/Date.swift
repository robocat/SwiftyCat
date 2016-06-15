//
//  Date.swift
//  SwiftyCat
//
//  Created by Simon Støvring on 26/08/2015.
//  Copyright © 2015 Robocat. All rights reserved.
//

import Foundation

public func minutes(_ timeInterval : TimeInterval) -> TimeInterval {
    return timeInterval * 60
}

public func hours(_ timeInterval : TimeInterval) -> TimeInterval {
    return minutes(timeInterval) * 60
}

public func days(_ timeInterval : TimeInterval) -> TimeInterval {
    return hours(timeInterval) * 24
}
