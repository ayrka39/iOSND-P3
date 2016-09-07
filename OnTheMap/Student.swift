//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by David on 8/21/16.
//  Copyright © 2016 David. All rights reserved.
//
import Foundation

struct Student {
	
	//student location data for table and map view
	var firstName: String? = ""
	var lastName: String? = ""
	var latitude: Double?
	var longitude: Double?
	var mapString: String?
	var mediaURL: String?
	var objectId: String?
	var uniqueKey: String? 
	var createdAt: NSString?
	var updatedAt: NSString?
	
	//constructing student from dictionary
	init(dictionary: JSONDictionary){
		
		if let firstName = dictionary["firstName"] as? String {
			self.firstName = firstName
		}
		if let lastName = dictionary["lastName"] as? String {
			self.lastName = lastName
		}
		if let latitude = dictionary["latitude"] as? Double {
			self.latitude = latitude
		}
		if let longitude = dictionary["longitude"] as? Double {
			self.longitude = longitude
		}
		if let mapString = dictionary["mapString"] as? String {
			self.mapString = mapString
		}
		if let mediaURL = dictionary["mediaURL"] as? String {
			self.mediaURL = mediaURL
		}
		if let objectId = dictionary["objectId"] as? String {
			self.objectId = objectId
		}
		if let uniqueKey = dictionary["uniqueKey"] as? String {
			self.uniqueKey = uniqueKey
		}
		if let createdAt = dictionary["createdAt"] as? NSString {
			self.createdAt = createdAt
		}
		if let updatedAt = dictionary["updatedAt"] as? NSString {
			self.updatedAt = updatedAt
		}
	
	}
	
}



