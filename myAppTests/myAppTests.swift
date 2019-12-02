//
//  myAppTests.swift
//  myAppTests
//
//  Created by Kate Roberts on 01/12/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import XCTest


class myAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
       
        let app = XCUIApplication()
        app.launch()
        setupSnapshot(app)
        snapshot("main")
//
//        let collectionViewsQuery = app.collectionViews
//        collectionViewsQuery.cells.containing(.staticText, identifier:"+").children(matching: .staticText)["+"].tap()
//
//        app.buttons["Eat Now"].tap()
//
//        snapshot("faceController")
//        app.buttons["Rate It!"].tap()
//
//        snapshot("confetti")
//        let iMASuperstarButton = app.buttons["I'm a superstar"]
//        iMASuperstarButton.tap()
//
//       // snapshot("mainAfterTry")
//        collectionViewsQuery.children(matching: .cell).element(boundBy: 15).children(matching: .staticText)["+"].tap()
//        app.buttons["Eat Later"].tap()
//       // snapshot("dataInput")
//        app.buttons["Set The Target!"].tap()
//        snapshot("target")
//        iMASuperstarButton.tap()
//
        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//        
//        let app = XCUIApplication()
//        app.collectionViews.cells.containing(.staticText, identifier:"+").children(matching: .staticText)["+"].tap()
//        app.buttons["Eat Now"].tap()
//        
//        let rateItButton = app.buttons["Rate It!"]
//        rateItButton.tap()
//        rateItButton.tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//
//        #   "iPhone 8 Plus",
//        #   "iPhone SE",
//        #   "iPhone X",
//        #   "iPad Pro (12.9-inch)",
//        #   "iPad Pro (9.7-inch)",
//        #   "Apple TV 1080p"
    }

    func testLaunchPerformance() {
      //  if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
           // measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
            //    XCUIApplication().launch()
        //    }
       // }
    }
}
