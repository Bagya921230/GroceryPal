//
//  SignUpVMTests.swift
//  GroceryPalTests
//
//  Created by Aparna Prasad on 1/5/21.
//  Copyright © 2021 iit. All rights reserved.
//
@testable import GroceryPal
import XCTest

class SignUpVMTests: XCTestCase {

    var viewModel : SignUpVM!

       override func setUp() {
               super.setUp()
               viewModel = SignUpVM()
       }
       
        func testNameIsEmpty() throws {
            XCTAssertFalse(viewModel.sendValues(name: "", email: "aparna@gmail.com", pw: "123", cpw: "123"))
        }
        
        func testNameIsNotEmpty() throws {
             XCTAssertTrue(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "123"))
        }
    
        func testEmailIsEmpty() throws {
            XCTAssertFalse(viewModel.sendValues(name: "Aparna", email: "", pw: "123", cpw: "123"))
        }
         
         func testEmailIsNotEmpty() throws {
             XCTAssertTrue(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "123"))
         }
    
        func testEmailIsNotValid() throws {
            XCTAssertFalse(viewModel.validEmail(email: "aparna"))
        }
        
        func testEmailIsValid() throws {
            XCTAssertTrue(viewModel.validEmail(email: "aparna@gmail.com"))
        }
    
        func testEmailIsNotValidInSendValues() throws {
            XCTAssertFalse(viewModel.sendValues(name: "Aparna", email: "aparna", pw: "123", cpw: "123"))
        }
    
        func testPwIsEmpty() throws {
            XCTAssertFalse(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "", cpw: "123"))
        }
        
        func testPwIsNotEmpty() throws {
            XCTAssertTrue(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "123"))
        }
    
        func testCPwIsEmpty() throws {
            XCTAssertFalse(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: ""))
        }
           
        func testCPwIsNotEmpty() throws {
             XCTAssertTrue(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "123"))
        }
    
        func testPasswordNotMatching() throws {
              XCTAssertFalse(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "1234"))
        }
            
        func testPasswordMatches() throws {
              XCTAssertTrue(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "123"))
        }
    
        func testCreateUserValidateSuccess() throws {
              XCTAssertTrue(viewModel.sendValues(name: "Aparna", email: "aparna@gmail.com", pw: "123", cpw: "123"))
        }
    
        func testCreateUserFailureInSignIn() throws {
            let exp = expectation(description: "Check auth sign in issue")
            var finalResult: Bool = false
            
            viewModel.createUser(email: "aparna@mailinator.com", pw: "123", name: "aparna", completion: { (result) in
                finalResult=result
                exp.fulfill()
            })
            
            waitForExpectations(timeout: 10)
            XCTAssertFalse(finalResult)

        }
    
        func testCreateUserFailureInFireStore() throws {
            let exp = expectation(description: "Check firestore issue")
            var finalResult: Bool = false
            
            viewModel.addToFireStore(name: "aparna", uid: "NxCxS6GaFzM7C7Z6UQftA16VZV03", completion: { (result) in
                finalResult=result
                exp.fulfill()
            })
            
            waitForExpectations(timeout: 10)
            XCTAssertTrue(finalResult)
        }
}
