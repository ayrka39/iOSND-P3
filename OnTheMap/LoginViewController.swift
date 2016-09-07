//
//  ViewController.swift
//  OnTheMap
//
//  Created by David on 8/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {

	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var facebookButton: FBSDKLoginButton!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	let facebook = FacebookClient()
	var accessToken: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.email.delegate = self
		self.password.delegate = self
		self.facebookButton.delegate = self
		FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	// Mark: Login
	
	@IBAction func loginPressed(sender: AnyObject) {
		auth.login(username: email.text!, password: password.text!) { (success, error) in
			self.spinner.startAnimating()
			guard error == nil else {
				self.spinner.stopAnimating()
				self.showAlertLogin("Login Failed", message: error!, actionTitle: "Dismiss")
				return
			}
			self.loginSuccess()
		}
	}
	
	@IBAction func signUpPressed(sender: AnyObject) {
		let urlString = Udacity.signUp
		let url = NSURL(string: urlString)!
		let app = UIApplication.sharedApplication()
		app.openURL(url)
	}
	
	// login and logout via facebook
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
		accessToken = FBSDKAccessToken.currentAccessToken().tokenString
		facebook.login(accessToken) { (success, error) in
			guard error == nil else {
				print("login fail \(error)")
				return
			}
			self.loginSuccess()
		}
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
		accessToken = ""
	}
	
	private func loginSuccess() {
		moveToTabBar()
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if (email.text?.isEmpty ?? true) {
			password.enabled = false
			textField.resignFirstResponder()
		} else if textField == email {
			password.enabled = true
			password.becomeFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
		return true
	}
}
