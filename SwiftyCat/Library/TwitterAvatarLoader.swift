//
//  TwitterAvatarLoader.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit
import Forbind
import ForbindExtensions

public class TwitterAvatarLoader {
	public class func loadAvatar(handle: String) -> Promise<Result<UIImage>> {
		let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: conf, delegate: Delegate(), delegateQueue: nil)
		let url = NSURL(string: "https://avatars.io/twitter/" + handle + "?size=large")
		let data = url => session.dataTask => { data, reponse in data }
		let image = data => UIImage.init
		return image => dispatch(dispatch_get_main_queue()) => pause(0.001)
	}
	
	class Delegate: NSObject, NSURLSessionTaskDelegate {
		func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: NSURLRequest? -> Void) {
			let mutRequest = request.mutableCopy() as! NSMutableURLRequest
			let newRequest: NSURLRequest?
			
			if let URL = mutRequest.URL {
				let urlComponents = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false)
				urlComponents?.scheme = "https"
				mutRequest.URL = urlComponents?.URL
				newRequest = mutRequest.copy() as? NSURLRequest
			} else {
				newRequest = nil
			}
			
			completionHandler(newRequest)
		}
	}
}
