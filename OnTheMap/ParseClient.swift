//
//  APIHander.swift
//  OnTheMap
//
//  Created by David on 8/25/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation
import MapKit

class ParseClient {
	

	// MARK: get student locations
	func getStudentLocations(completionForLocations: (annotations: [MKPointAnnotation], error: String?) -> Void) {
		
		var annotations = [MKPointAnnotation]()

		// buil URL and configure a request
		requestForGetMethod(true) { (request, error) in
			guard error == nil else {
				completionForLocations(annotations: [], error: nil)
				return
			}
			// make a request and parse JSON
			dataTask(request) { (result, response, error) in
				guard error == nil else {
					completionForLocations(annotations: [], error: error)
					return
				}
				// extract data from JSON
				guard let resultsArr = result!["results"] as? [JSONDictionary] else {
					completionForLocations(annotations: [], error: "No results in the returned data")
					return
				}
				wonderful.students.removeAll()
				for result in resultsArr {
					let students = Student(dictionary: result)
					wonderful.students.append(students)
				}
				
				// map annotation
				for student in wonderful.students {
					var location: CLLocationCoordinate2D
					let latitude = student.latitude ?? 71.1685636
					let longitude = student.longitude ?? 25.7736893
					location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
					let annotation = MKPointAnnotation()
					annotation.coordinate = location
					annotation.title = student.firstName! + " " + student.lastName!
					annotation.subtitle = student.mediaURL
					annotations.append(annotation)
				}
				completionForLocations(annotations: annotations, error: nil)
			}
		}
	}
	
	func getAStudentLocation(completionForLocation: (data: AnyObject?, error: String?) -> Void) {
		
		//build URL and configure a request
		requestForGetMethod(false) { (request, error) in
			
			guard error == nil else {
				completionForLocation(data: nil, error: "error1")
				return
			}
			// make a request and parse JSON
			dataTask(request) { (result, response, error) in
				
				guard error == nil else {
					completionForLocation(data: nil, error: "error2")
					return
				}
				// extract data from JSON
				guard let resultArr = result!["results"] as? [JSONDictionary] else {
					completionForLocation(data: nil, error: "No results in the returned data")
					return
				}
				// save object ID 
				userInfo.objectId = resultArr[0]["objectId"]! as! String
				completionForLocation(data: resultArr[0], error: nil)
			
			}
		}
	}
	
	
	func postAStudentLocation(mapString: String, mediaURL: String, completionForPostLocation: (data: AnyObject?, error: String?) -> Void) {
		
		let jsonBody = "{\"uniqueKey\": \"\(userInfo.uniqueKey)\", \"firstName\": \"\(userInfo.firstName)\", \"lastName\": \"\(userInfo.lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(userInfo.latitude), \"longitude\": \(userInfo.longitude)}"
		
		requestForPostMethod(jsonBody) { (request, error) in
			print("post request: \(request)")
			guard error == nil else {
				completionForPostLocation(data: nil, error: error)
				return
			}
			dataTask(request) { (result, response, error) in
				print("post result: \(result)")
				guard error == nil else {
					completionForPostLocation(data: nil, error: error)
					return
				}
				guard let resultDict = result! as? JSONDictionary else {
					completionForPostLocation(data: nil, error: error)
					return
				}
				userInfo.objectId = resultDict["objectId"] as! String
				completionForPostLocation(data: userInfo.objectId, error: nil)
			}
		}
	}
	
	func putAStudentLocation(objectId: String, mapString: String, mediaURL: String, completionForPutLocaiton: (success: Bool, error: String?) -> Void) {
		
		let jsonBody = "{\"uniqueKey\": \"\(userInfo.uniqueKey)\", \"firstName\": \"\(userInfo.firstName)\", \"lastName\": \"\(userInfo.lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(userInfo.latitude), \"longitude\": \(userInfo.longitude)}"
		
		requestForPutMethod(jsonBody) { (request, error) in
			guard error == nil else {
				completionForPutLocaiton(success: false, error: error)
				return
			}
			dataTask(request) { (result, response, error) in
				guard error == nil else {
					completionForPutLocaiton(success: false, error: error)
					return
				}
				completionForPutLocaiton(success: true, error: nil)
			}
		}
	}
	
}

	var api = ParseClient()
