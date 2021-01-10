//
//  SignUpUITest.swift
//  GroceryPalUITests
//
//  Created by Aparna Prasad on 1/8/21.
//  Copyright © 2021 iit. All rights reserved.
//

import XCTest

class SignUpUITest: XCTestCase {

       var app: XCUIApplication!
       var signUpView: XCUIElement!

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
       
       func testSignUpLoad() {
           app.buttons["LET'S GETS STARTED"].tap()
           signUpView = app.otherElements["signUpView"]
           XCTAssertTrue(signUpView.exists)
       }


       func testAlertWhenNameNotGiven()
       {
            app.buttons["LET'S GETS STARTED"].tap()
            signUpView = app.otherElements["signUpView"]
            XCTAssertTrue(signUpView.exists)
                  
            signUpView.buttons["SIGN UP"].tap()
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the name."].exists)
            app.alerts["Alert"].tap()
       }
       
       func testAlertWhenEmailNotGiven()
       {
            app.buttons["LET'S GETS STARTED"].tap()
            signUpView = app.otherElements["signUpView"]
            XCTAssertTrue(signUpView.exists)
              
            signUpView.textFields["name_SignUp"].tap()
            signUpView.textFields["name_SignUp"].typeText("aparna")
            signUpView.tap()
            signUpView.buttons["SIGN UP"].tap()
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the email."].exists)
            app.alerts["Alert"].tap()
       }
    
        func testAlertWhenEmailIsNotValid()
        {
             app.buttons["LET'S GETS STARTED"].tap()
             signUpView = app.otherElements["signUpView"]
             XCTAssertTrue(signUpView.exists)
                   
             signUpView.textFields["name_SignUp"].tap()
             signUpView.textFields["name_SignUp"].typeText("aparna")
             signUpView.textFields["email_SignUp"].tap()
             signUpView.textFields["email_SignUp"].typeText("aparna")
             signUpView.tap()
             signUpView.buttons["SIGN UP"].tap()
             XCTAssertTrue(app.alerts.element.staticTexts["Email address is not valid."].exists)
             app.alerts["Alert"].tap()
        }
       
       func testAlertWhenPasswordNotGiven()
       {
            app.buttons["LET'S GETS STARTED"].tap()
            signUpView = app.otherElements["signUpView"]
            XCTAssertTrue(signUpView.exists)
                  
            signUpView.textFields["name_SignUp"].tap()
            signUpView.textFields["name_SignUp"].typeText("aparna")
            signUpView.textFields["email_SignUp"].tap()
            signUpView.textFields["email_SignUp"].typeText("aparna@gmail.com")
            signUpView.tap()
            signUpView.buttons["SIGN UP"].tap()
            
            XCTAssertTrue(app.alerts.element.staticTexts["Please enter the password."].exists)
            app.alerts["Alert"].tap()
       }
    
    
        func testAlertWhenCPasswordNotGiven()
        {
             app.buttons["LET'S GETS STARTED"].tap()
             signUpView = app.otherElements["signUpView"]
             XCTAssertTrue(signUpView.exists)
                   
             signUpView.textFields["name_SignUp"].tap()
             signUpView.textFields["name_SignUp"].typeText("aparna")
             signUpView.textFields["email_SignUp"].tap()
             signUpView.textFields["email_SignUp"].typeText("aparna@gmail.com")
             signUpView.secureTextFields["password_SignUp"].tap()
             signUpView.secureTextFields["password_SignUp"].typeText("aparna123")
             
             signUpView.buttons["SIGN UP"].tap()
             signUpView.buttons["SIGN UP"].tap()

             XCTAssertTrue(app.alerts.element.staticTexts["Please confirm the password."].exists)
             app.alerts["Alert"].tap()
        }
    
    
        func testAlertWhenPasswordMisMatch()
        {
             app.buttons["LET'S GETS STARTED"].tap()
             signUpView = app.otherElements["signUpView"]
             XCTAssertTrue(signUpView.exists)
                   
             signUpView.textFields["name_SignUp"].tap()
             signUpView.textFields["name_SignUp"].typeText("aparna")
             signUpView.textFields["email_SignUp"].tap()
             signUpView.textFields["email_SignUp"].typeText("aparna@gmail.com")
             signUpView.secureTextFields["password_SignUp"].tap()
             signUpView.secureTextFields["password_SignUp"].typeText("aparna123")
             signUpView.secureTextFields["cpassword_SignUp"].tap()
             signUpView.secureTextFields["cpassword_SignUp"].typeText("aparna1234")

             signUpView.buttons["SIGN UP"].tap()
             signUpView.buttons["SIGN UP"].tap()
            
             XCTAssertTrue(app.alerts.element.staticTexts["Passwords mismatch."].exists)
             app.alerts["Alert"].tap()
        }
       
       func testSignInFail()
       {
            app.buttons["LET'S GETS STARTED"].tap()
            signUpView = app.otherElements["signUpView"]
            XCTAssertTrue(signUpView.exists)
              
            signUpView.textFields["name_SignUp"].tap()
            signUpView.textFields["name_SignUp"].typeText("aparna")
            signUpView.textFields["email_SignUp"].tap()
            signUpView.textFields["email_SignUp"].typeText("aparna@mailinator.com")
            signUpView.secureTextFields["password_SignUp"].tap()
            signUpView.secureTextFields["password_SignUp"].typeText("aparna123")
            signUpView.secureTextFields["cpassword_SignUp"].tap()
            signUpView.secureTextFields["cpassword_SignUp"].typeText("aparna123")
            
            signUpView.buttons["SIGN UP"].tap()
            signUpView.buttons["SIGN UP"].tap()
        
            XCTAssertTrue(app.alerts["Alert"].waitForExistence(timeout: 5))
       }

}
