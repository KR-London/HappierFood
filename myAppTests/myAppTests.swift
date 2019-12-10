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
       
//        let app = XCUIApplication()
//        app.launch()
//        setupSnapshot(app)
//        snapshot("main")
        
        let app = XCUIApplication()
        app.launch()
        setupSnapshot(app)
        snapshot("main")
        app.collectionViews.cells.containing(.staticText, identifier:"+").children(matching: .staticText)["+"].tap()
        snapshot("dataInputScreen")
        app.buttons["Eat Now"].tap()
        snapshot("faceRate")
        app.buttons["Rate It!"].tap()
        snapshot("confetti")
        app.buttons["I'm a superstar"].tap()
        snapshot("backToMain")
       
        
                
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
    
        func testTopButtons() {
            
            let app = XCUIApplication()
             app.launch()
            setupSnapshot(app)
            app.navigationBars["HappyFoods"].children(matching: .button).element(boundBy: 0).tap()
            snapshot("history")
            
            let element1 = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0)
            element1.swipeDown()
            XCUIApplication().navigationBars["HappyFoods"].buttons["Stats"].tap()
            
            app.buttons["little dude1"].tap()
            snapshot("coaching")
            app.buttons["How will this app help me?"].tap()
            
            let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
            snapshot("2ndtutorial1")
            element.swipeLeft()
            snapshot("2ndtutorial1")
            element.swipeLeft()
            snapshot("2ndtutorial1")
            element.swipeLeft()
            snapshot("2ndtutorial1")
            element.swipeLeft()
            snapshot("2ndtutorial1")
            element.swipeLeft()
            snapshot("2ndtutorial1")
            element.swipeLeft()
            snapshot("2ndtutorial1")
            element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            snapshot("2ndtutorial2")
                        
           
    //        let app = XCUIApplication()
    //        app.launch()
    //        setupSnapshot(app)
    //        snapshot("main")
            
//            let app = XCUIApplication()
//            app.launch()
//            setupSnapshot(app)
//            snapshot("main")
//            app.collectionViews.cells.containing(.staticText, identifier:"+").children(matching: .staticText)["+"].tap()
//            snapshot("dataInputScreen")
//            app.buttons["Eat Now"].tap()
//            snapshot("faceRate")
//            app.buttons["Rate It!"].tap()
//            snapshot("confetti")
//            app.buttons["I'm a superstar"].tap()
//            snapshot("backToMain")
           
            
                    
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
        
    func testResetData(){
        let app = XCUIApplication()
        app.launch()
        
        
//        let app = app2
//        app.buttons["Is this for me?"].tap()
//
//        let app2 = app
//        app2/*@START_MENU_TOKEN@*/.staticTexts["Level App Your Food!"]/*[[".buttons[\"Level App Your Food!\"].staticTexts[\"Level App Your Food!\"]",".staticTexts[\"Level App Your Food!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app2/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food"]/*[[".buttons[\"I wanna Happy my Food\"].staticTexts[\"I wanna Happy my Food\"]",".staticTexts[\"I wanna Happy my Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app2/*@START_MENU_TOKEN@*/.staticTexts["....Okay...."]/*[[".buttons[\"....Okay....\"].staticTexts[\"....Okay....\"]",".staticTexts[\"....Okay....\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Try Food"].tap()
//        app.buttons["Finish It"].tap()
//        app.buttons["button"].tap()
//        app.buttons["Rate It!"].tap()
//        app.buttons["I'm a superstar"].tap()
//
//        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
//        element.tap()
//        element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeDown()
        app.buttons["little dude1"].tap()
        app.buttons["Settings"].tap()
        app.buttons["Clear All Data"].tap()
        app.alerts["Are you sure?"].scrollViews.otherElements.buttons["Delete All"].tap()
                
        
    }
    
    
    func testOnboarding(){
        let app = XCUIApplication()
        app.launch()
        setupSnapshot(app)
        snapshot("onboarding1")
        app.staticTexts["Is this for me?"].tap()
        snapshot("onboardingquiz")
        
        
        app.sliders["50%"]/*@START_MENU_TOKEN@*/.press(forDuration: 0.9);/*[[".tap()",".press(forDuration: 0.9);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let staticText = app/*@START_MENU_TOKEN@*/.staticTexts["👎"]/*[[".buttons[\"👎\"].staticTexts[\"👎\"]",".staticTexts[\"👎\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        let levelAppYourFoodStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Level App Your Food!"]/*[[".buttons[\"Level App Your Food!\"].staticTexts[\"Level App Your Food!\"]",".staticTexts[\"Level App Your Food!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        levelAppYourFoodStaticText.tap()
        snapshot("no_no")
        
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeDown()
//
//
//
//        let app2 = app
//        app2/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food "]/*[[".buttons[\"I wanna Happy my Food \"].staticTexts[\"I wanna Happy my Food \"]",".staticTexts[\"I wanna Happy my Food \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeDown()
//        app.staticTexts["You said that you eat a lot of different foods "].swipeDown()
//        app.sliders["79%"].swipeLeft()
//        staticText.tap()
//        app.buttons["Level App Your Food!"].tap()
//        app2/*@START_MENU_TOKEN@*/.staticTexts["Support Resources"]/*[[".buttons[\"Support Resources\"].staticTexts[\"Support Resources\"]",".staticTexts[\"Support Resources\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.staticTexts["Come back anytime you are ready to try new foods. "].swipeDown()
//        staticText2.tap()
//        levelAppYourFoodStaticText.tap()
//        app2/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food"]/*[[".buttons[\"I wanna Happy my Food\"].staticTexts[\"I wanna Happy my Food\"]",".staticTexts[\"I wanna Happy my Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app2/*@START_MENU_TOKEN@*/.staticTexts["....Okay...."]/*[[".buttons[\"....Okay....\"].staticTexts[\"....Okay....\"]",".staticTexts[\"....Okay....\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Try Food"].tap()
//        app.buttons["Nibble It"].tap()
//        app.buttons["button"].tap()
//
//
//
//        app.sliders["34%"].tap()
//
//        let iWannaHappyMyFoodStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food"]/*[[".buttons[\"I wanna Happy my Food\"].staticTexts[\"I wanna Happy my Food\"]",".staticTexts[\"I wanna Happy my Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        iWannaHappyMyFoodStaticText.tap()
//
//        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//        element.swipeDown()
//        app.buttons["Level App Your Food!"].tap()
//        iWannaHappyMyFoodStaticText.tap()
//
//        let app2 = app
//        app2/*@START_MENU_TOKEN@*/.staticTexts["....Okay...."]/*[[".buttons[\"....Okay....\"].staticTexts[\"....Okay....\"]",".staticTexts[\"....Okay....\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Try Food"].tap()
//        app.buttons["Nibble It"].tap()
//        app.buttons["button"].tap()
//        app.buttons["Rate It!"].tap()
//        app.buttons["I'm a superstar"].tap()
//
//        let element2 = element.children(matching: .other).element
//        element2.swipeLeft()
//        element2.swipeLeft()
//        element2.swipeDown()
//        app2/*@START_MENU_TOKEN@*/.icons["Happy Foods "]/*[[".otherElements[\"Home screen icons\"]",".icons.icons[\"Happy Foods \"]",".icons[\"Happy Foods \"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
                
        
    }
    
    func testOnboarding2(){
        
        let app = XCUIApplication()
        app.launch()
        setupSnapshot(app)
        app.buttons["Is this for me?"].tap()

        let levelAppYourFoodStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Level App Your Food!"]/*[[".buttons[\"Level App Your Food!\"].staticTexts[\"Level App Your Food!\"]",".staticTexts[\"Level App Your Food!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        levelAppYourFoodStaticText.tap()
        snapshot("onboarding1")
       // app/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food"]/*[[".buttons[\"I wanna Happy my Food\"].staticTexts[\"I wanna Happy my Food\"]",".staticTexts[\"I wanna Happy my Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let levelAppYourFoodStaticText2 = app.staticTexts["I wanna Happy my Food"]
        levelAppYourFoodStaticText2.tap()
        snapshot("onboarding2")
        let levelAppYourFoodStaticText3 = app.staticTexts["....Okay...."]
        levelAppYourFoodStaticText3.tap()
        snapshot("onboarding3")
        let levelAppYourFoodStaticText4 = app.staticTexts["Try Food"]
               levelAppYourFoodStaticText4.tap()
               snapshot("onboarding4")
        let levelAppYourFoodStaticText5 = app.staticTexts["Smell It"]
        levelAppYourFoodStaticText5.tap()
        snapshot("onboarding5")
     
    }
    
    func testOnboarding3(){
          
          let app = XCUIApplication()
          app.launch()
          setupSnapshot(app)
          app.buttons["Is this for me?"].tap()
          let levelAppYourFoodStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Level App Your Food!"]/*[[".buttons[\"Level App Your Food!\"].staticTexts[\"Level App Your Food!\"]",".staticTexts[\"Level App Your Food!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
          levelAppYourFoodStaticText.tap()
         // app/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food"]/*[[".buttons[\"I wanna Happy my Food\"].staticTexts[\"I wanna Happy my Food\"]",".staticTexts[\"I wanna Happy my Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
          let levelAppYourFoodStaticText2 = app.staticTexts["I wanna Happy my Food"]
          levelAppYourFoodStaticText2.tap()
          let levelAppYourFoodStaticText3 = app.staticTexts["....Okay...."]
          levelAppYourFoodStaticText3.tap()
          let levelAppYourFoodStaticText4 = app.staticTexts["Not Eating Now"]
          levelAppYourFoodStaticText4.tap()
          snapshot("firsttarget")
       
      }
    
    func testOnbaording4(){
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Is this for me?"].tap()
        app.sliders["50%"].swipeRight()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.staticTexts["👎"]/*[[".buttons[\"👎\"].staticTexts[\"👎\"]",".staticTexts[\"👎\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["Level App Your Food!"]/*[[".buttons[\"Level App Your Food!\"].staticTexts[\"Level App Your Food!\"]",".staticTexts[\"Level App Your Food!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("yes-no")
        
    }
    
    func testOnbaording5(){
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Is this for me?"].tap()
        app.sliders["50%"].swipeRight()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.staticTexts["👍"]/*[[".buttons[\"👍\"].staticTexts[\"👍\"]",".staticTexts[\"👍\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["Level App Your Food!"]/*[[".buttons[\"Level App Your Food!\"].staticTexts[\"Level App Your Food!\"]",".staticTexts[\"Level App Your Food!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("yes-yes")
        app2/*@START_MENU_TOKEN@*/.staticTexts["I wanna Happy my Food "]/*[[".buttons[\"I wanna Happy my Food \"].staticTexts[\"I wanna Happy my Food \"]",".staticTexts[\"I wanna Happy my Food \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
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


