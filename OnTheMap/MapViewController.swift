//
//  MapViewController.swift
//  OnTheMap
//
//  Created by David on 8/19/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!

	let api = DataManager()
	let auth = AuthManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		loadStudentLocation()
	}
	
	func loadStudentLocation() {
		spinner.startAnimating()
		api.getStudentLocations { (annotations, error) in
			guard error == nil else {
				self.showAlert("alert", message: error!, actionTitle: "Dismiss")
				return
			}
			performUpdateOnMain(){
				self.mapView.addAnnotations(annotations)
				self.spinner.stopAnimating()
			}
		}
	}
	
	// update location
	@IBAction func pinPressed(sender: AnyObject) {
		api.getAStudentLocation { (data, error) in
			guard error == nil else {
				self.showAlert("alert", message: error!, actionTitle: "Dismiss")
				return
			}
			self.showAlertWithOptions()
		}
	}
	
	// log out
	@IBAction func logoutPressed(segue: UIStoryboardSegue) {
		auth.deleteSessionID { (success, error) in
			guard error == nil else {
				self.showAlert("Error", message: error!, actionTitle: "Dismiss")
				return
			}
			self.moveToLogin()
		}
	}
	
	// reload data
	@IBAction func refreshPressed(sender: AnyObject) {
		loadStudentLocation()
	}
}


extension MapViewController: MKMapViewDelegate {

	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		let reuseId = "pin"
		var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
		
		if pinView == nil {
			pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
			pinView!.canShowCallout = true
			pinView!.pinTintColor = UIColor.redColor()
			pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
		} else {
			pinView!.annotation = annotation
		}
		
		return pinView
	}


	func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		let app = UIApplication.sharedApplication()
		if control == view.rightCalloutAccessoryView {
			if var mediaURL = (view.annotation?.subtitle!)! as String? {
				if mediaURL.hasPrefix("www") {
					mediaURL = "https://" + mediaURL
				}
				guard let url = NSURL(string: mediaURL) where app.canOpenURL(url) else {
					showAlert("alert", message: "unable to open URL", actionTitle: "dismiss")
					return
				}
				app.openURL(url)
				}
			}
		}
}



