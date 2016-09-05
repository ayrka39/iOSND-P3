//
//  ListViewController.swift
//  OnTheMap
//
//  Created by David on 8/19/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit

class ListViewController: UIViewController  {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	let api = DataManager()
	let auth = AuthManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		loadStudentLocation()
	}
		
	func loadStudentLocation() {
		spinner.startAnimating()
		api.getStudentLocations { (success, error) in
			guard error == nil else {
				self.showAlert("Alert", message: error!, actionTitle: "Dismiss")
				return
			}
			performUpdateOnMain() {
				self.tableView.reloadData()
				self.spinner.stopAnimating()
			}
		}
	}

	// update location
	@IBAction func pinPressed(sender: AnyObject) {
		api.getAStudentLocation { (data, error) in
			guard error == nil else {
				self.showAlert("Alert", message: error!, actionTitle: "Dismiss")
				return
			}
			self.showAlertWithOptions()
		}
	}
	
	// log out
	@IBAction func logoutPressed(sender: AnyObject) {
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


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return wonderful.students.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
		let user = wonderful.students[indexPath.row]
		cell.textLabel?.text = user.firstName! + " " + user.lastName!
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowIndexPath indexPath: NSIndexPath) {
		let app = UIApplication.sharedApplication()
		let user = wonderful.students[indexPath.row]
		var mediaURL = user.mediaURL
		if mediaURL!.hasPrefix("www") {
			mediaURL = "https://" + mediaURL!
		}
		guard let url = NSURL(string: mediaURL!) where app.canOpenURL(url) else {
			showAlert("alert", message: "unable to open URL", actionTitle: "dismiss")
			return
		}
		app.openURL(url)
	}
}
