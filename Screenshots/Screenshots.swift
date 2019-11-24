//
//  Screenshots.swift
//  Screenshots
//
//  Created by Noah Emmet on 11/23/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import XCTest

/*
To run screenshots:
> fastlane snapshot
*/

class Screenshots: XCTestCase {
	
	override func setUp() {
		continueAfterFailure = false
		
		let app = XCUIApplication()
    setupSnapshot(app, waitForAnimations: true)
		app.launch()
	}
	
	override func tearDown() { }
	
	func testScreenshots() {
		// UI tests must launch the application that they test.
    
		let app = XCUIApplication()
		
		snapshot("01-Events")
    
    app.tables.buttons.element(boundBy: 1).tap()
    
    snapshot("02-Event Detail")
    
    let whereButton = app.scrollViews.buttons.element(boundBy: 1)
    whereButton.tap()
    
    snapshot("03-Venue Detail")
	}
}
