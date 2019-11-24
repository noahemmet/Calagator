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
  let iPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
  /// Appended at the end of screenshot filenames.
  var appendix: String!
  
	override func setUp() {
		continueAfterFailure = false
    XCUIDevice.shared.orientation = iPad ? .landscapeLeft : .portrait
    appendix = iPad ? "-force_landscapeleft" : ""
    
		let app = XCUIApplication()
    setupSnapshot(app, waitForAnimations: true)
		app.launch()
	}
	
	override func tearDown() { }
	
	func testScreenshots() {
		// UI tests must launch the application that they test.
    
		let app = XCUIApplication()
		
    if !iPad {
      snapshot("01-Events" + appendix)
    }
    
    let eventButton = app.tables.buttons.element(boundBy: 1)
    eventButton.tap()
    
    snapshot("02-Event Detail" + appendix)
    
//    let whereButton = app.scrollViews.buttons.element(boundBy: 1)
//    whereButton.tap()
//    
//    snapshot("03-Venue Detail" + appendix)
	}
}
