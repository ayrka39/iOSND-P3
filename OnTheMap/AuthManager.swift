//
//  AuthManager.swift
//  OnTheMap
//
//  Created by David on 8/29/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

class AuthManager {
	
	let user = User.sharedInstacne
	
	// get accessed to Udacity
	func createSessionID(username username: String, password: String, completionForSessionID: (success: Bool, error: String?) -> Void){

		let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
		
		// build URL and configure a request
		postRequest(true, jsonBody: jsonBody) { (request, error) in
			guard error == nil else {
				completionForSessionID(success: false, error: error)
				return
			}
			// make a request and parse JSON
			dataTask(true, request: request) { (result, response, error) in
				guard error == nil else {
					completionForSessionID(success: false, error: error)
					return
				}
				// extract data from JSON
				guard let accountDict = result!["account"] as? JSONDictionary else {
					completionForSessionID(success: false, error: "There was no account key in the response")
					return
				}
				self.user.uniqueKey = accountDict["key"]! as! String
				completionForSessionID(success: true, error: nil)
			  DataManager().getUserData()
			}
		}
	}
	
	// delete a session ID to log out
	func deleteSessionID(completionForDeleteSessionID: (success: Bool, error: String?) -> Void) {
		
		// build URL and configure a request
		deleteRequest { (request, error) in
			guard error == nil else {
				completionForDeleteSessionID(success: false, error: nil)
				return
			}
			// make a request and parse JSON
			dataTask(true, request: request) { (result, response, error) in
				guard error == nil else {
					completionForDeleteSessionID(success: false, error: error)
					return
				}
				completionForDeleteSessionID(success: true, error: nil)
			}
		}
	}
}
		



