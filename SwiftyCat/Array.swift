//
//  Array.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 30/06/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation

public func filterNils<T : SequenceType, U where T.Generator.Element == Optional<U>>(sequence : T) -> [U] {
	return filter(sequence) { $0 != nil }.map { $0! }
}
