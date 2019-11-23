//
//  Screenshots.swift
//  Screenshots
//
//  Created by Noah Emmet on 11/23/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import XCTest

// ~/.fastlane/bin/fastlane snapshot

class Screenshots: XCTestCase {
	
	override func setUp() {
		continueAfterFailure = false
		
		let app = XCUIApplication()
		setupSnapshot(app)
		app.launch()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testScreenshots() {
		// UI tests must launch the application that they test.
		let app = XCUIApplication()
		app.launch()
		
	}
}
