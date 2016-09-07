//
//  LocationView.swift
//  OnTheMap
//
//  Created by David on 9/4/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension LocationViewController {
	
	func findView() {
		mapView.hidden = true
		submitButton.hidden = true
		linkTextField.hidden = true
	}
	
	func submitView() {
		mapView.hidden = false
		linkTextField.hidden = false
		submitButton.hidden = false
		questionLabel.hidden = true
		userLocationField.hidden = true
		bottomView.hidden = true
		findButton.hidden = true
		topView.backgroundColor = UIColor(red: 72/255, green: 115/255, blue: 169/255, alpha: 1.0)
		cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
	}

	
}