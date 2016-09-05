//
//  ViewController.swift
//  OnTheMap
//
//  Created by David on 8/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	// Mark: Login
	
	@IBAction func loginPressed(sender: AnyObject) {

		let auth = AuthManager()
		auth.createSessionID(username: email.text!, password: password.text!) { (success, error) in
			guard error == nil else {
				self.showAlertLogin("Login Failed", message: error!, actionTitle: "Dismiss")
				return
			}
			self.spinner.startAnimating()
			self.loginSuccess()
		}
	}
	
	@IBAction func signUpPressed(sender: AnyObject) {
		let urlString = Udacity.signUp
		let url = NSURL(string: urlString)!
		let app = UIApplication.sharedApplication()
		app.openURL(url)
	}
	
	@IBAction func signInwithFacebookPressed(sender: AnyObject) {
		showAlertLogin("sorry 😥", message: "SignIn with Facebook is currently unavailable. Please try to log in with Udacity username", actionTitle: "OK")
		
	}
	
	private func loginSuccess() {
		moveToTabBar()
	}
	
}
