//
//  dispatch.swift
//  SwiftyCat
//
//  Created by Ulrik Damm on 11/01/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import Foundation

//public func dispatch_main(_ block: (Void) -> Void) {
//	DispatchQueue.main.async(execute: block)
//}
//
//public func dispatch_background(_ block: (Void) -> Void) {
//    DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosBackground).async(execute: block)
//}
//
//public func dispatch_after(_ seconds: Double, queue: DispatchQueue? = nil, callback: (Void) -> Void) {
//    let dispatch_to: DispatchQueue = queue ?? DispatchQueue.main
//	let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//	dispatch_to.after(when: time, block: callback)
//}
