//
//  HappierFoodsTests.swift
//  HappierFoodsTests
//
//  Created by Kate Roberts on 04/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import XCTest
@testable import HappierFoods

class HappierFoodsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScreenshots() {
       // let app = XCUIApplication()
      //  XCUIDevice.shared.orientation = .portrait
        
        //let tabBarsQuery = XCUIApplication().tabBars
        // Home
       // tabBarsQuery.buttons.element(boundBy: 0).tap()
        //snapshot("0-Home")
        
        // Map
       // tabBarsQuery.buttons.element(boundBy: 1).tap()
       // app.otherElements["eventlocation"].tap()
       // snapshot("1-Map")
        
        // Twitter
        //tabBarsQuery.buttons.element(boundBy: 2).tap()
        //snapshot("2-Twiter")
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

}
