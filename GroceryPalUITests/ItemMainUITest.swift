//
//  ItemMainUITest.swift
//  GroceryPalUITests
//
//  Created by Aparna Prasad on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//


import XCTest
import iOSDropDown
@testable import GroceryPal

class ItemMainUITest: XCTestCase {

    var app: XCUIApplication!
    var signInView: XCUIElement!
    var homeView: XCUIElement!

    override func setUp() {
      app = XCUIApplication()
      app.launch()
      testSignInLoad()
    }
    
    override func tearDown() {
    }
    
    func testSignInLoad() {
        if(app.otherElements["landingView"].waitForExistence(timeout: 5))
        {

             app.buttons["Sign In"].tap()
             signInView = app.otherElements["signInView"]
             XCTAssertTrue(signInView.exists)
                      
             signInView.textFields["email_SignIn"].tap()
             signInView.textFields["email_SignIn"].typeText("aparna@mailinator.com")
             signInView.secureTextFields["password_SignIn"].tap()
             signInView.secureTextFields["password_SignIn"].typeText("test12345")
             signInView.tap()
             signInView.buttons["SIGN IN"].tap()
                   
             XCTAssertTrue(app.otherElements["homeView"].waitForExistence(timeout: 5))
        }
        else
        {
            XCTAssertTrue(app.otherElements["homeView"].waitForExistence(timeout: 5))
        }
    }
    
    func testItemMainPage()
    {
        homeView = app.otherElements["homeView"]
        XCTAssertTrue(homeView.exists)
        app.otherElements["homeItemsListView"].tap()
        XCTAssertTrue(app.otherElements["itemsMainView"].waitForExistence(timeout: 5))
    }
    
    func testItemDetailPage()
    {
        homeView = app.otherElements["homeView"]
        XCTAssertTrue(homeView.exists)
        app.otherElements["homeItemsListView"].tap()
        XCTAssertTrue(app.otherElements["itemsMainView"].waitForExistence(timeout: 5))
        
        if(app.otherElements["itemListView"].exists)
        {
            // table cell click
            app.tables.cells.element(boundBy: 0).tap()
            XCTAssertTrue(app.otherElements["itemDetailView"].exists)
            app.navigationBars.buttons.element(boundBy: 0).tap()
            
            // top add button click
            app.navigationBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.otherElements["itemDetailView"].exists)
            app.navigationBars.buttons.element(boundBy: 0).tap()

            //search bar
            let searchfield = app.searchFields.element(boundBy: 0)
            searchfield.tap()
            searchfield.typeText("a")

        }
        
    }
    
    func testValidateAddItem()
    {
        homeView = app.otherElements["homeView"]
        XCTAssertTrue(homeView.exists)
        app.otherElements["homeItemsListView"].tap()
        XCTAssertTrue(app.otherElements["itemsMainView"].waitForExistence(timeout: 5))
        
        if(app.otherElements["itemListView"].exists)
        {
            // top add button click
            app.navigationBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.otherElements["itemDetailView"].exists)

            //validate item name
            app.navigationBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the item name."].exists)
            app.alerts["Alert"].tap()
            
            //validate price
            let detailView = app.otherElements["itemDetailView"]
            detailView.textFields["name_Item"].tap()
            detailView.textFields["name_Item"].typeText("abc")
            app.navigationBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the price."].exists)
            app.alerts["Alert"].tap()
            
            //validate price when select non unit
            detailView.tap()
            detailView.textFields["uom_Item"].tap()
            detailView.tables.cells.element(boundBy: 1).tap()
            app.navigationBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the price."].exists)
            app.alerts["Alert"].tap()
            
            //validate per val when select non unit
            detailView.textFields["nonUnitPrice_Item"].tap()
            detailView.textFields["nonUnitPrice_Item"].typeText("20")
            app.navigationBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the per unit value."].exists)
            app.alerts["Alert"].tap()
        }
        
    }
    
}
