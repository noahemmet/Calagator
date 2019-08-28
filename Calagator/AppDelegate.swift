//
//  AppDelegate.swift
//  Calagator
//
//  Created by Noah Emmet on 6/17/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import UIKit
import SwiftRichString
import FeedKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//		let feedURL = URL(string: "http://calagator.org/events.atom")!
		
		let html = "feawfe"
		let attr = try! NSAttributedString(html: html)
		let feedURL = Bundle.main.url(forResource: "Data/example_data", withExtension: "atom")!
		let parser = FeedParser(URL: feedURL)
		parser.parseAsync { result in
			print(result)
		}
//		let feedURL = URL(string: "http://calagator.org/events.atom")!
//		let feedURL = Bundle.main.url(forResource: "Data/example_data", withExtension: "atom")!
//		let parser = FeedParser(URL: feedURL)
//		parser.parseAsync { result in
//			print(result)
//		}
		
		
		
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

