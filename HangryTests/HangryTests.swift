//
//  HangryTests.swift
//  HangryTests
//
//  Created by 高毓彬 on 2018/8/17.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import XCTest
@testable import Hangry

class HangryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testColorTransfer() {
        let color1 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        let answer1 = RestaurantViewController.transferStringToColor("#000000")
        XCTAssert(answer1 == color1, "transferStringToColor does not transfer correctly")
        
        let color2 = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        let answer2 = RestaurantViewController.transferStringToColor("#FFFFFF")
        print(color2,answer2)
        XCTAssert(answer2 == color2, "transferStringToColor does not transfer correctly")
    }
    
    func testRestaurant() {
        let res:Restaurant = Restaurant(id: "123", name: "123", location: "123", menu: "123", review: nil, thumb: "123", costForTwo: 123, cuisines: "123", rating: "123", rating_color: "123")
        XCTAssertNotNil(res,"Restaurant is nil")
        XCTAssertNotNil(res.id,"Restaurant's attribute id is nil")
    }
    
    func testRestaurantReview() {
        let resReview:RestaurantReview = RestaurantReview(rating: 123, review_text: "123", time: "123", username: "123", user_level: 123, avatar: "123")
        XCTAssertNotNil(resReview,"RestaurantReview is nil")
        XCTAssertNotNil(resReview.username,"RestaurantReview's attribute username is nil")
    }
    
    func testCoreData() {
        let model = ResutaurantBookmarkCDModel.sharedInstance
        XCTAssertNotNil(model, "Core Data model is nil")
        XCTAssertNotNil(model.restaurantBookmarkdb, "Core Data restaurantBookmarkdb is nil")
        XCTAssertNotNil(model.getRestaurantBookmarkCD(), "there is nothing in restaurantBookmarkdb")
    }
    
}
