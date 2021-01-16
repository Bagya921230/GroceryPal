//
//  ItemDetailVMTests.swift
//  GroceryPalTests
//
//  Created by Aparna Prasad on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

@testable import GroceryPal
import XCTest

class ItemDetailVMTests: XCTestCase {

    var viewModel : ItemDetailVM!
    var itemList = [Item]()
    let fireStoreQueries = FireStoreItemQueries()
    
       override func setUp() {
               super.setUp()
               viewModel = ItemDetailVM()
               viewModel.onLoad()
       }
       
        func testNameIsEmpty() throws {
            
            let result = viewModel.sendValues(name: "", category: "Dairy", uom: "unit", notes: "xxx", price: "200", nonUnitPrice: "2000", perVal: "10", roLevel: "4", image: nil, isEditMode: false, selectedItem: nil, barcode: "")
            XCTAssertFalse(result)
        }
    
        func testUnitPriceIsEmpty() throws {
            
            let result = viewModel.sendValues(name: "abc", category: "Dairy", uom: "unit", notes: "xxx", price: "", nonUnitPrice: "2000", perVal: "10", roLevel: "4", image: nil, isEditMode: false, selectedItem: nil, barcode: "")
            XCTAssertFalse(result)
        }
    
        func testNonUnitPriceIsEmpty() throws {
            
            let result = viewModel.sendValues(name: "abc", category: "Dairy", uom: "kg", notes: "xxx", price: "100", nonUnitPrice: "", perVal: "10", roLevel: "4", image: nil, isEditMode: false, selectedItem: nil, barcode: "")
            XCTAssertFalse(result)
        }
    
        func testPerValIsEmpty() throws {
            
            let result = viewModel.sendValues(name: "abc", category: "Dairy", uom: "kg", notes: "xxx", price: "100", nonUnitPrice: "2000", perVal: "", roLevel: "4", image: nil, isEditMode: false, selectedItem: nil, barcode: "")
            XCTAssertFalse(result)
        }
    
        func testUpdateValidationSuccess() throws {
            
            let item = Item(name: "Apple", category: "Fruit", uom: "g", unitPrice: 300, perValue: 200, roLevel: 50, notes: "Test", image: "", id: "0", barcode: "")
               
            let result = viewModel.sendValues(name: "abc", category: "Dairy", uom: "unit", notes: "xxx", price: "100", nonUnitPrice: "2000", perVal: "5", roLevel: "4", image: nil, isEditMode: true, selectedItem: item, barcode: "")
            XCTAssertTrue(result)
        }
    
        func testGetUnitPrice() throws {
            
            let val = viewModel.getUnitPrice(selectedUnit: "unit", price: 100, nonUnitPrice: 200)
            XCTAssert(val == 100)
        }
    
        func testGetNonUnitPrice() throws {
            
            let val = viewModel.getUnitPrice(selectedUnit: "kg", price: 100, nonUnitPrice: 200)
            XCTAssert(val == 200)
        }
    
    
        /*func testAddItem() throws {
    
               let item = Item(name: "Apple", category: "Fruit", uom: "g", unitPrice: 300, perValue: 200, roLevel: 50, notes: "Test", image: "", id: "0")
    
                let exp = expectation(description: "Check add is successful")
                var finalResult: Bool = false
    
                viewModel.storeItem(item: item, image: nil, completion: { (result) in
                           finalResult=result
                           exp.fulfill()
                })
    
                waitForExpectations(timeout: 10)
                XCTAssertTrue(finalResult)
        }*/
    
    
        func testUpdateItemSuccess() throws {
    
               let item = Item(name: "Apple", category: "Fruit", uom: "g", unitPrice: 300, perValue: 200, roLevel: 50, notes: "Test", image: "", id: "0", barcode: "")
               
                           let exp = expectation(description: "Check update is successful")
                           var finalResult: Bool = false
               
                           viewModel.updateItem(item: item, image: nil, completion: { (result) in
                                      finalResult=result
                                      exp.fulfill()
                           })
               
                waitForExpectations(timeout: 10)
                XCTAssertTrue(finalResult)
        }
    
    
       func testSelectedDropDownSuccess()
       {
          let index  = viewModel.getSelectedDropDownIndex(list: ["abc", "pqr"], findText: "pqr")
          XCTAssert(index == 1)
       }
    
        func testSelectedDropDownEmptyList()
        {
           let index  = viewModel.getSelectedDropDownIndex(list: [String](), findText: "")
           XCTAssert(index == 0)
        }

}
