//
//  SignInUITest.swift
//  GroceryPalUITests
//
//  Created by Aparna Prasad on 1/6/21.
//  Copyright © 2021 iit. All rights reserved.
//

import XCTest
@testable import GroceryPal

class SignInUITest: XCTestCase {

    var app: XCUIApplication!
    var signInView: XCUIElement!

    override func setUp() {
      app = XCUIApplication()
      app.launch()
        
      if(app.otherElements["homeView"].waitForExistence(timeout: 5))
      {
        app.buttons["logout_home"].tap()
      }
    }
    
    override func tearDown() {
    }
    
    func testSignInLoad() {
        app.buttons["Sign In"].tap()
        signInView = app.otherElements["signInView"]
        XCTAssertTrue(signInView.exists)
    }

    func testAlertWhenUserNameNotGiven()
    {
        app.buttons["Sign In"].tap()
        signInView = app.otherElements["signInView"]
        XCTAssertTrue(signInView.exists)
                  
        signInView.buttons["SIGN IN"].tap()
        XCTAssertTrue(app.alerts.element.staticTexts["Please enter the email."].exists)
        app.alerts["Alert"].tap()
    }
    
    func testAlertWhenPasswordNotGiven()
    {
         app.buttons["Sign In"].tap()
         signInView = app.otherElements["signInView"]
         XCTAssertTrue(signInView.exists)
          
         signInView.textFields["email_SignIn"].tap()
         signInView.textFields["email_SignIn"].typeText("aparna@gmail.com")
         signInView.buttons["SIGN IN"].tap()
         XCTAssertTrue(app.alerts.element.staticTexts["Please enter the password."].exists)
         app.alerts["Alert"].tap()
    }
    
    func testSignInSuccess()
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
    
    func testSignInFail()
    {
         app.buttons["Sign In"].tap()
         signInView = app.otherElements["signInView"]
         XCTAssertTrue(signInView.exists)
           
         signInView.textFields["email_SignIn"].tap()
         signInView.textFields["email_SignIn"].typeText("aparna@gmail.com")
         signInView.secureTextFields["password_SignIn"].tap()
         signInView.secureTextFields["password_SignIn"].typeText("test12345")
         signInView.tap()
         signInView.buttons["SIGN IN"].tap()
        
         XCTAssertTrue(app.alerts["Alert"].waitForExistence(timeout: 5))
    }
    
}
