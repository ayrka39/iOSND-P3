//
//  GetRequest.swift
//  OnTheMap
//
//  Created by David on 8/30/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

func requestForGetMethod(isAll: Bool, completionForGet: (request: NSMutableURLRequest, error: String?) -> Void) {
	
	// build URL
	let urlbaseLocation = Parse.baseURL + Parse.StudentLocation
	let urlStringForAll = urlbaseLocation + Parameter.allLocations
	let urlForAll = NSURL(string: urlStringForAll)!
	let urlStringForOne = urlbaseLocation + Parameter.oneLocation
	let urlForOne = NSURL(string: urlStringForOne)!
		
	// configure a request
	let request: NSMutableURLRequest
	
	if isAll {
		request = NSMutableURLRequest(URL: urlForAll)
	} else {
		request = NSMutableURLRequest(URL: urlForOne)
	}

	request.addValue(Parse.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
	request.addValue(Parse.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")

	completionForGet(request: request, error: nil)
}

func requestForPostMethod(jsonBody: String, completionForPost: (request: NSMutableURLRequest, error: String?) -> Void) {
	
	// build URL
	let urlStringLocation = Parse.baseURL + Parse.StudentLocation
	let urlLocation = NSURL(string: urlStringLocation)!
	
	// configure a request
	let request: NSMutableURLRequest
	
	request = NSMutableURLRequest(URL: urlLocation)
	request.HTTPMethod = "POST"
	request.addValue(Parse.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
	request.addValue(Parse.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
	request.addValue("application/json", forHTTPHeaderField: "Content-Type")
	request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
	
	completionForPost(request: request, error: nil)
}

// To update an existing student location
func requestForPutMethod(jsonBody: String, completionForPut: (request: NSMutableURLRequest, error: String?) -> Void) {
	
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

// Make a request
func dataTask(request: NSMutableURLRequest, completionForDataTask: (result: AnyObject!, response: NSURLResponse?, error: String?) -> Void) {
	
	
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
		
		// parse JSON
		var parsedResult: AnyObject?
		do {
			parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
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


