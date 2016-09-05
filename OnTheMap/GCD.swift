//
//  GCD.swift
//  OnTheMap
//
//  Created by David on 8/23/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

func performUpdateOnMain(updates: () -> Void) {
	
	dispatch_async(dispatch_get_main_queue()) {
		
		updates()
		
	}
}

