//
//  DataHolder.swift
//  OnTheMap
//
//  Created by David on 8/30/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

class StudentLocations {
	
	// singleton
	static let sharedInstance = StudentLocations()
	private init() {}
	
	// place to store all the student locations
	var students = [Student]()
	
}

let wonderful = StudentLocations.sharedInstance