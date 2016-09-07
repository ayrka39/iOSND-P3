//
//  AuthManager.swift
//  OnTheMap
//
//  Created by David on 8/29/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

class UdacityClient {
	

	let session = NSURLSession.sharedSession()
	
	// get accessed to Udacity
	func login(username username: String, password: String, completionForLogin: (success: Bool, error: String?) -> Void){
		
		let urlString = Udacity.baseURL + Udacity.sessionPath
		let url = NSURL(string: urlString)!
		
		// configure a request
		let request = NSMutableURLRequest(URL: url)
		
		request.HTTPMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
		request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
		
		let task = session.dataTaskWithRequest(request) { (data, response, error) in
			
			// GUARD: Was there an error?
			guard error == nil else {
				completionForLogin(success: false, error: "error whatever")
				return
			}
			// GUARD: Did we get a successful 2XX response?
			let statusCode = (response as? NSHTTPURLResponse)?.statusCode
			if statusCode >= 400 && statusCode <= 499 {
				completionForLogin(success: false, error: "check your credentials")
				print("statusCode: \(statusCode)")
			} else if statusCode >= 500 && statusCode <= 599 {
				completionForLogin(success: false, error: "connection error")
			} else if statusCode <= 200 && statusCode >= 299 {
				completionForLogin(success: true, error: nil)
			}

			
			// GUARD: Was there any data returned?
			guard let data = data else {
				completionForLogin(success: false, error: "no data")
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
				completionForLogin(success: false, error: "There was no account key in the response")
				return
			}
			
			guard let sessionDict = parsedResult!["session"] as? JSONDictionary else {
				completionForLogin(success: false, error: "There was no account key in the response")
				return
			}
			
			userInfo.uniqueKey = accountDict["key"]! as! String
			userInfo.sessionID = sessionDict["id"]! as! String
			userInfo.sessionExp = sessionDict["expiration"] as! String
			completionForLogin(success: true, error: nil)
			self.getUserData()
		}
		task.resume()
	}
	

	
	// delete a session ID to log out
	func logout(completionForLogout: (success: Bool, error: String?) -> Void) {
		
		//build URL
		let urlString = Udacity.baseURL + Udacity.sessionPath
		let url = NSURL(string: urlString)!
		
		// configure a request
		let request = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "DELETE"

		var xsrfCookie: NSHTTPCookie? = nil
		let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
		
		for cookie in sharedCookieStorage.cookies! {
			if cookie.name == "XSRF-TOKEN" {
				xsrfCookie = cookie
			}
		}
		
		if let xsrfCookie = xsrfCookie {
			request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
		}

		let task = session.dataTaskWithRequest(request) { (data, response, error) in
			
			// Did we get a successful 2XX response?
			let statusCode = (response as? NSHTTPURLResponse)?.statusCode
			if statusCode >= 400 && statusCode <= 499 {
				completionForLogout(success: false, error: "check your credentials")
			} else if statusCode >= 500 && statusCode <= 599 {
				completionForLogout(success: false, error: "connection error")
			} else if statusCode <= 200 && statusCode >= 299 {
				completionForLogout(success: true, error: nil)
				print("statusCode: \(statusCode)")
			}
			// check if necessary to remove first five characters from Udacity API responses
			let newData = data?.subdataWithRange(NSMakeRange(5, (data?.length)! - 5))
			
			// parse JSON
			var parsedResult: AnyObject?
			do {
				parsedResult = try NSJSONSerialization.JSONObjectWithData(newData!, options: .AllowFragments)
			} catch {
				print("Could not parse the data as JSON: '\(data)")
				return
			}
			
			guard let sessionDict = parsedResult!["session"] as? JSONDictionary else {
				completionForLogout(success: false, error: "There was no account key in the response")
				return
			}
			userInfo.sessionID = sessionDict["id"]! as! String
			userInfo.sessionExp = sessionDict["expiration"] as! String

			completionForLogout(success: true, error: nil)
		}
		task.resume()
	}

	
	func getUserData() {
		
		let url = NSURL(string:Udacity.baseURL + Udacity.users + Parameter.uniqueKey)!
		let request = NSMutableURLRequest(URL: url)

		let task = session.dataTaskWithRequest(request) { data, response, error in
			if error != nil { // Handle error...
				return
			}
			
			// check if necessary to remove first five characters from Udacity API responses
			let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
			
			var parsedResult: AnyObject?
			do {
				parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
			} catch {
				print("Could not parse the data as JSON: '\(data)")
				return
			}
			guard let resultDict = parsedResult!["user"] as? JSONDictionary else {
				print("no user data")
				return
			}
			userInfo.firstName = (resultDict["first_name"] as? String)!
			userInfo.lastName = (resultDict["last_name"] as? String)!
			
			
		}
		task.resume()
	}
}

var auth = UdacityClient()

