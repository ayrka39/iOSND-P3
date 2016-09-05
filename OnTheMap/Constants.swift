//
//  Constants.swift
//  OnTheMap
//
//  Created by David on 8/21/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation
	
struct Udacity {
	
	static let baseURL = "https://www.udacity.com/api/"
	static let signUp = "https://www.udacity.com/account/auth#!/signup"
	static let userInfo = "users/"
	static let sessionPath = "session"
}

struct Parse {
	
	static let baseURL = "https://parse.udacity.com/parse/classes/"
	static let applicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
	static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
	static let StudentLocation = "StudentLocation"
}

struct Parameter {
	
	static let allLocations = "?limit=100&order=-updatedAt"
	static let oneLocation = "?where=%7B%22uniqueKey%22%3A%22\(uniqueKey)%22%7D"
	static let uniqueKey = "\(User.sharedInstacne.uniqueKey)"
	static let objectID = "\(User.sharedInstacne.objectId)"
	
}


