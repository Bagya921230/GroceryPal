//
//  SignInVMTests.swift
//  GroceryPalTests
//
//  Created by Aparna Prasad on 1/4/21.
//  Copyright © 2021 iit. All rights reserved.
//
@testable import GroceryPal
import XCTest

class SignInVMTests: XCTestCase {

    var viewModel : SignInVM!

    override func setUp() {
        super.setUp()
        viewModel = SignInVM()
    }
    
    func testEmailIsEmpty() throws {
        XCTAssertFalse(viewModel.sendValues(email: "", pw: "123"))
    }
    
    func testEmailIsNotEmpty() throws {
        XCTAssertTrue(viewModel.sendValues(email: "aparna@gmail.com", pw: "123"))
    }
    
    func testPwIsEmpty() throws {
        XCTAssertFalse(viewModel.sendValues(email: "aparna@gmail.com", pw: ""))
    }
    
    func testPwIsNotEmpty() throws {
        XCTAssertTrue(viewModel.sendValues(email: "aparna@gmail.com", pw: "123"))
    }

    func testLoginSuccess() throws {
        let exp = expectation(description: "Check login is successful")
        var finalResult: Bool = false
        
        
        viewModel.signInUser(email: "aparna@mailinator.com", pw: "test12345", completion: { (result) in
            finalResult=result
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10)
        XCTAssertTrue(finalResult)
        
    }
    
    func testLoginFailure() throws {
        let exp = expectation(description: "Check login is failing")
        var finalResult: Bool = false
        
        viewModel.signInUser(email: "aparna@gmail.com", pw: "test", completion: { (result) in
            finalResult=result
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10)
        XCTAssertFalse(finalResult)

    }
}
