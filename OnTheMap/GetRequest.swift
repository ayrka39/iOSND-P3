//
//  GetRequest.swift
//  OnTheMap
//
//  Created by David on 8/30/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

enum URLSelect: String {
	case urlForAll
	case urlForOne
	case urlForUserData
}

func getRequest(urlSelect: URLSelect, addValue: Bool, completionForGet: (request: NSMutableURLRequest, error: String?) -> Void) {
	
	// build URL
	let urlbaseLocation = Parse.baseURL + Parse.StudentLocation
	let urlStringForAll = urlbaseLocation + Parameter.allLocations
	let urlForAll = NSURL(string: urlStringForAll)!
	let urlStringForOne = urlbaseLocation + Parameter.oneLocation
	let urlForOne = NSURL(string: urlStringForOne)!
	let urlStringForUserData = Udacity.baseURL + Udacity.userInfo + Parameter.uniqueKey
	let urlForUserData = NSURL(string: urlStringForUserData)!
		
	// configure a request
	let request: NSMutableURLRequest
	
	switch urlSelect {
	case .urlForAll:
		request = NSMutableURLRequest(URL: urlForAll)
	case .urlForOne:
		request = NSMutableURLRequest(URL: urlForOne)
	case .urlForUserData:
		request = NSMutableURLRequest(URL: urlForUserData)
	default:
		return
	}
	
	if addValue {
	request.addValue(Parse.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
	request.addValue(Parse.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
	} else {
		return
	}
	completionForGet(request: request, error: nil)
}