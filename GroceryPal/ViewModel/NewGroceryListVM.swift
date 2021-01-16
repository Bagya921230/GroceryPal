//
//  NewGroceryListVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

class NewGroceryListVM {
    let dispatch = DispatchGroup()
    var fireStoreGroceryQueries = FireStoreGroceryQueries()
    var delegate: NewGroceryListViewControllerDelegate?

    
    func sendValues(listName: String) -> Bool
    {
        if listName.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the list name.")
        } else {
            let grocery = Grocery(id: "", name: listName, total: 0, itemCount: 0)
                        
            storeGrocery(grocery: grocery)
            return true
        }
        return false
    }
    
    func storeGrocery(grocery: Grocery)
    {
        fireStoreGroceryQueries.createGroceryList(grocery: grocery){ result in
            if let grocery = result as? Grocery {
                self.delegate?.addSuccess(grocery: grocery)
            } else {
                print("Cannot add the grocery")
            }
         }
    }
    
}
