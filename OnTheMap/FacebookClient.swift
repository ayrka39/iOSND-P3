//
//  FacebookClient.swift
//  OnTheMap
//
//  Created by David on 9/7/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

class FacebookClient {
	
	func login(accessToken: String, completionForFBLogin: (success: Bool, error: String?) -> Void) {
		
		let urlString = Udacity.baseURL + Udacity.sessionPath
		let url = NSURL(string: urlString)!
		let request = NSMutableURLRequest(URL: url)
		
		request.HTTPMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let jsonBody = "{\"facebook_mobile\": {\"access_token\": \"\(accessToken)\"}}"
		request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
		
		let session = NSURLSession.sharedSession()
		let task = session.dataTaskWithRequest(request) { data, response, error in
			
			// GUARD: Was there an error?
			guard error == nil else {
				completionForFBLogin(success: false, error: "error whatever")
				return
			}
			// GUARD: Did we get a successful 2XX response?
			let statusCode = (response as? NSHTTPURLResponse)?.statusCode
			if statusCode >= 400 && statusCode <= 499 {
				completionForFBLogin(success: false, error: "check your credentials")
				print("statusCode: \(statusCode)")
			} else if statusCode >= 500 && statusCode <= 599 {
				completionForFBLogin(success: false, error: "connection error")
			} else if statusCode <= 200 && statusCode >= 299 {
				completionForFBLogin(success: true, error: nil)
			}
			
			// GUARD: Was there any data returned?
			guard let data = data else {
				completionForFBLogin(success: false, error: "no data")
				return
			}
			
			// check if necessary to remove first five characters from Udacity API responses
			let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
			
			// parse JSON
			var parsedResult: AnyObject?
			do {
				parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
			} catch {
				print("Could not parse the data as JSON: '\(data)")
				return
			}
			guard let accountDict = parsedResult!["account"] as? JSONDictionary else {
				completionForFBLogin(success: false, error: "There was no account key in the response")
				return
			}
			userInfo.uniqueKey = accountDict["key"]! as! String
			completionForFBLogin(success: true, error: nil)
			UdacityClient().getUserData()

		}
		task.resume()
	}
	
}