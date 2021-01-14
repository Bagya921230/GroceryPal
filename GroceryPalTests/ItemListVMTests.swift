//
//  ItemListVMTests.swift
//  GroceryPalTests
//
//  Created by Aparna Prasad on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//
@testable import GroceryPal
import XCTest

class ItemListVMTests: XCTestCase {

    var viewModel : ItemListVM!
    var itemList = [Item]()
    let fireStoreQueries = FireStoreItemQueries()
    
       override func setUp() {
               super.setUp()
               viewModel = ItemListVM()
               viewModel.onLoad(fireStoreQueries: fireStoreQueries)
               prepareList()
       }
       
        func testSearchBar() throws {
            XCTAssertTrue(viewModel.filterList(searchText: "app", itemList: itemList).count == 1)
        }
    
         func testDeleteItem() throws {
            
           let item = Item(name: "Apple", category: "Fruit", uom: "g", unitPrice: 300, perValue: 200, roLevel: 50, notes: "Test", image: "", id: "123")
            
            let exp = expectation(description: "Check delete is successful")
            var finalResult: Bool = false
                   
            viewModel.deleteItem(item: item, completion: { (result) in
                       finalResult=result
                       exp.fulfill()
            })
                   
            waitForExpectations(timeout: 10)
            XCTAssertTrue(finalResult)
         }
    
          func prepareList()
          {
            let item = Item(name: "Apple", category: "Fruit", uom: "g", unitPrice: 300, perValue: 200, roLevel: 50, notes: "Test", image: "", id: "")
            
            let item1 = Item(name: "Orange", category: "Fruit", uom: "g", unitPrice: 300, perValue: 200, roLevel: 50, notes: "Test", image: "", id: "")
                
             itemList.append(item)
             itemList.append(item1)
          }
}
