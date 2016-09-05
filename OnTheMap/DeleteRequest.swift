//
//  DeleteRequest.swift
//  OnTheMap
//
//  Created by David on 8/30/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

func deleteRequest(completeForDelete: (request: NSMutableURLRequest, error: String?) -> Void) {
	
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
	
	completeForDelete(request: request, error: nil)
}