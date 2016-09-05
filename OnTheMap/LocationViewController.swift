//
//  LocationViewController.swift
//  OnTheMap
//
//  Created by David on 8/19/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class LocationViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
	
	
	@IBOutlet weak var topView: UIView!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var linkTextField: UITextField!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var userLocationField: UITextField!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	@IBOutlet weak var bottomView: UIView!
	@IBOutlet weak var findButton: UIButton!
	@IBOutlet weak var submitButton: UIButton!
	
	let api = DataManager()
	var userLocation = [CLPlacemark]()
	var userLatitude = CLLocationDegrees()
	var userLongitude = CLLocationDegrees()
	var userLocationName = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.linkTextField.delegate = self
		self.userLocationField.delegate = self
		findView()
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}

	
	@IBAction func findOnMapPressed(sender: AnyObject) {
		guard userLocationField.text != "" else {
			showAlert("Empty Field", message: "Please enter your location", actionTitle: "OK")
			return
		}
		let place = userLocationField.text
		getLocation(place!)
	}
	
	
	@IBAction func submitPressed(sender: AnyObject) {
		guard linkTextField.text != "" else {
			showAlert("Empty Field", message: "Please enter a link to share", actionTitle: "OK")
			return
		}
		postLocation()
	}
	
	@IBAction func cancelPressed(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// Geocode the address
	func getLocation(place: String) {
		spinner.startAnimating()
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(place) { (placemark, error) in
			guard error == nil else {
				self.spinner.stopAnimating()
				self.showAlert("alert", message: "Unable to find the location", actionTitle: "Try Again")
				return
			}
			self.userLocation = placemark!
			self.configureMap()
			self.spinner.stopAnimating()
			self.submitView()
			}
		}
	
	// Place a pin of the location in the map
	func configureMap() {
		let topPlacemarkResult = self.userLocation[0]
		let placemarkToPlace = MKPlacemark(placemark: topPlacemarkResult)
		let annotation = MKPointAnnotation()
		annotation.coordinate = placemarkToPlace.coordinate
		userLocationName = placemarkToPlace.name!
		userLatitude = annotation.coordinate.latitude
		userLongitude = annotation.coordinate.longitude
		
		let pinCoordinate = CLLocationCoordinate2DMake(userLatitude, userLongitude)
		let span = MKCoordinateSpanMake(0.1, 0.1)
		let region = MKCoordinateRegionMake(pinCoordinate, span)
		performUpdateOnMain() {
			self.mapView.addAnnotation(annotation)
			self.mapView.setRegion(region, animated: true)
			self.mapView.regionThatFits(region)
		}
	}
	
	// post a student locaiton
	func postLocation() {
		let mapString = userLocationField.text!
		let mediaURL = linkTextField.text!
		api.postAStudentLocation(mapString, mediaURL: mediaURL) { (data, error) in
			guard error == nil else {
				self.showAlert("", message: error!, actionTitle: "ok")
				return
			}
			self.dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	// Get keyboard dismissal
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
}








