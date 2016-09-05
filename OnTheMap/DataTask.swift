//
//  DataTask.swift
//  OnTheMap
//
//  Created by David on 8/28/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit
import Foundation

// Make a request
func dataTask(isUdacity: Bool, request: NSMutableURLRequest, completionForDataTask: (result: AnyObject!, response: NSURLResponse?, error: String?) -> Void) {
	
	let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
	let session = NSURLSession(configuration: config)
	let task = session.dataTaskWithRequest(request) { (data, response, error) in
		
		// GUARD: Was there an error?
		guard error == nil else {
			completionForDataTask(result: nil, response: nil, error: "There was an error in the request response")
			return
		}
		// GUARD: Did we get a successful 2XX response?
		let statusCode = (response as? NSHTTPURLResponse)?.statusCode
		guard statusCode >= 200 && statusCode <= 299 else {
			completionForDataTask(result: nil, response: nil, error: "Your request returned a status code other than 2xx!")
			print("statusCode: \(statusCode)")
			return
		}
		
		// GUARD: Was there any data returned?
		guard let data = data else {
			completionForDataTask(result: nil, response: response as! NSHTTPURLResponse, error: "There was no data in the response")
			return
		}
		
		// check if necessary to remove first five characters from Udacity API responses
		let newData: NSData
		if isUdacity {
			newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
		} else {
			newData = data
		}
		
		// parse JSON
		var parsedResult: AnyObject?
		do {
			parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
		} catch {
			print("Could not parse the data as JSON: '\(data)")
			completionForDataTask(result: nil, response: nil, error: "Could not parse the response to a readable format")
			return
		}
		
		// ready to use JSON
		completionForDataTask(result: parsedResult, response: nil, error: nil)
		}
	task.resume()
}

