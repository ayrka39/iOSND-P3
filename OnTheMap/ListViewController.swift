//
//  ListViewController.swift
//  OnTheMap
//
//  Created by David on 8/19/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
	
	var spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		tableView!.reloadData()
		spinner.center = self.view.center
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return wonderful.students.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
		let user = wonderful.students[indexPath.row]
		cell.textLabel?.text = user.firstName! + " " + user.lastName!
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		let app = UIApplication.sharedApplication()
		let user = wonderful.students[indexPath.row]
		var mediaURL = user.mediaURL
		if mediaURL!.hasPrefix("www.") {
			mediaURL = "https://" + mediaURL!
		}
		guard let url = NSURL(string: mediaURL!) where app.canOpenURL(url) else {
			showAlert("alert", message: "unable to open URL", actionTitle: "dismiss")
			return
		}
		app.openURL(url)
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
		spinner.startAnimating()
		auth.logout { (success, error) in
			guard error == nil else { return }
		}
		performUpdateOnMain() {
			self.spinner.stopAnimating()
			self.dismissViewControllerAnimated(true, completion: nil)
		}

	}
	
	// reload data
	@IBAction func refreshPressed(sender: AnyObject) {
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

}