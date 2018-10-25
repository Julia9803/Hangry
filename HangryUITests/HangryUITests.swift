//
//  HangryUITests.swift
//  HangryUITests
//
//  Created by 高毓彬 on 2018/8/17.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import XCTest

class HangryUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
        func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCUIApplication().tabBars.buttons["Restaurant"].tap()
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Profile"].tap()
        tabBarsQuery.buttons["Recipe"].tap()
        
        let restaurantButton = tabBarsQuery.buttons["Restaurant"]
        restaurantButton.tap()
        tabBarsQuery.buttons["Home"].tap()
        restaurantButton.tap()
    }
    
    func testRestaurantBookmark() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Restaurant"].tap()
        app.navigationBars["RESTAURANT"].buttons["Bookmarks"].tap()
        app.navigationBars["Hangry.RestaurantBookmarkTableView"].buttons["RESTAURANT"].tap()
        
    }
}
