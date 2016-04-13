//
//  AppStoreRateCount.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

//import Foundation
//import Forbind
//
//public class AppStoreRateCount {
//	public class func loadAppStoreRatingCount(appId: String) -> Promise<Result<Int>> {
//		guard let url = NSURL(string: "https://itunes.apple.com/lookup?id=" + appId) else { fatalError("Invalid URL from app Id \(appId)") }
//		let data = NSURLSession.sharedSession().dataTask(url) => { data, response in data }
//		let json = data => NSJSONSerialization.toJSON() => { $0.dictionaryValue }
//		return json => AppStoreRateCount.parse => dispatch(dispatch_get_main_queue()) => pause(0.001)
//	}
//	
//	private class func parse(data: NSDictionary) -> Int? {
//		let results = data["results"] as? [NSDictionary]
//		let count = results?.first?["userRatingCountForCurrentVersion"] as? Int
//		return count
//	}
//}
