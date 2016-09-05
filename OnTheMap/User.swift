//
//  User.swift
//  OnTheMapTest
//
//  Created by David on 8/26/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

class User {
	
	static let sharedInstacne = User()
	
	var sessionID = ""
	var uniqueKey = ""
	var sessionExp = ""
	var firstName = ""
	var lastName = ""
	
	var latitude: Double = 0.00
	var longitude: Double = 0.00
	var mapString = ""
	var mediaURL = ""
	var objectId = ""
	var createdAt = ""
	var updatedAt = ""
}