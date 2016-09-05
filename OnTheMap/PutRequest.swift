//
//  PutRequest.swift
//  OnTheMap
//
//  Created by David on 8/30/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

// To update an existing student location
func putRequest(jsonBody: String, completionForPut: (request: NSMutableURLRequest, error: String?) -> Void) {
	
	// build URL
	let parameter = Parameter.objectID
	let urlString = Parse.baseURL + Parse.StudentLocation + parameter
	let url = NSURL(string: urlString)!
	
	// configure a request
	let request = NSMutableURLRequest(URL: url)
	
	request.HTTPMethod = "PUT"
	request.addValue(Parse.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
	request.addValue(Parse.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
	request.addValue("application/json", forHTTPHeaderField: "Content-Type")
	request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)

	completionForPut(request: request, error: nil)
}

