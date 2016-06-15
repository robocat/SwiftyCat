//
//  String.swift
//  SwiftyCat
//
//  Created by Simon Støvring on 25/08/2015.
//  Copyright © 2015 Robocat. All rights reserved.
//

import Foundation

public extension String {
    public func format(_ args : CVarArg...) -> String {
        return NSString(format: self, arguments: getVaList(args)) as String
    }
}
