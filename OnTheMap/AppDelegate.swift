//
//  AppDelegate.swift
//  OnTheMap
//
//  Created by David on 8/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
	}
	
	
	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
		
		return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
	}


	func applicationWillResignActive(application: UIApplication) {
		
	}

	func applicationDidEnterBackground(application: UIApplication) {
		
	}

	func applicationWillEnterForeground(application: UIApplication) {
		
	}

	
	func applicationDidBecomeActive(application: UIApplication) {
		
		FBSDKAppEvents.activateApp()
	}
	
	func applicationWillTerminate(application: UIApplication) {
		
	}

}

