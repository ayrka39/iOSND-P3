//
//  Alert.swift
//  OnTheMap
//
//  Created by David on 8/26/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit

extension LocationViewController {
	
	func showAlert(title: String, message: String, actionTitle: String) {
		performUpdateOnMain(){
			let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
			let action = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
			alert.addAction(action)
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}
	
}

extension MapViewController {
	
	func showAlert(title: String, message: String, actionTitle: String) {
		performUpdateOnMain(){
			let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
			let action = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
			alert.addAction(action)
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}

	
	func showAlertWithOptions() {
		performUpdateOnMain() {
		let alert = UIAlertController(title: "", message: "\(userInfo.firstName), You Have Already Posted a Student Location. Would You Like to Overwrite Your Current Location?", preferredStyle: .Alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
		let okAction = UIAlertAction(title: "Overwrite", style: .Default, handler: { (action:UIAlertAction!) in
			self.moveToUpdate()
		})
			alert.addAction(cancelAction)
			alert.addAction(okAction)
			self.presentViewController(alert, animated: true, completion: nil)
	 }
	}

	
	func moveToUpdate() {
		performUpdateOnMain() {
		let withId = self.storyboard!.instantiateViewControllerWithIdentifier("LocationViewController")
		let controller = withId as! LocationViewController
		self.presentViewController(controller, animated: true, completion: nil)
		}
	}
	
}

extension ListViewController {
	
	func showAlert(title: String, message: String, actionTitle: String) {
		performUpdateOnMain(){
			let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
			let action = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
			alert.addAction(action)
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}
	
	func showAlertWithOptions() {
		performUpdateOnMain() {
			let alert = UIAlertController(title: "", message: "\(userInfo.firstName), You Have Already Posted a Student Location. Would You Like to Overwrite Your Current Location?", preferredStyle: .Alert)
			let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
			let okAction = UIAlertAction(title: "Overwrite", style: .Default, handler: { (action:UIAlertAction!) in
				self.moveToUpdate()
			})
			alert.addAction(cancelAction)
			alert.addAction(okAction)
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}
	
	func moveToUpdate() {
		performUpdateOnMain() {
		let withId = self.storyboard!.instantiateViewControllerWithIdentifier("LocationViewController")
		let controller = withId as! LocationViewController
		self.presentViewController(controller, animated: true, completion: nil)
		}
	}
	
}


extension LoginViewController {
	
	func showAlertLogin(title: String, message: String, actionTitle: String) {
		performUpdateOnMain() {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
		let action = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
		alert.addAction(action)
		self.presentViewController(alert, animated: true, completion: nil)
		}
	}
	
	func moveToTabBar() {
		performUpdateOnMain() {
			let controller = self.storyboard!.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
			self.presentViewController(controller, animated: true, completion: nil)
		}
	}
}