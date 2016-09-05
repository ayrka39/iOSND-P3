//
//  PostRequest.swift
//  OnTheMap
//
//  Created by David on 8/30/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

func postRequest(isSessionID: Bool, jsonBody: String, completionForPost: (request: NSMutableURLRequest, error: String?) -> Void) {
	
	// build URL
	let urlStringSession = Udacity.baseURL + Udacity.sessionPath
	let urlSession = NSURL(string: urlStringSession)!
	let urlStringLocation = Parse.baseURL + Parse.StudentLocation
	let urlLocation = NSURL(string: urlStringLocation)!
	
	// configure a request
	let request: NSMutableURLRequest

	if isSessionID {
		request = NSMutableURLRequest(URL: urlSession)
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
	} else {
		request = NSMutableURLRequest(URL: urlLocation)
		request.addValue(Parse.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
		request.addValue(Parse.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
	}
	
	request.HTTPMethod = "POST"
	request.addValue("application/json", forHTTPHeaderField: "Content-Type")
	request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
	
	completionForPost(request: request, error: nil)

}