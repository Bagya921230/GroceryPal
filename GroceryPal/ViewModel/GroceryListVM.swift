//
//  GroceryListVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

import Foundation

class GroceryListVM {

    var fireStoreGroceryQueries = FireStoreGroceryQueries()

    func onLoad(fireStoreGroceryQueries: FireStoreGroceryQueries) {
        fireStoreGroceryQueries.fetchGrocery()
        fireStoreGroceryQueries.fetchRestockItems()
    }
    
    func getGroceryList(groceryId: String) {
        fireStoreGroceryQueries.fetchGroceryItemList(groceryListId: groceryId)
    }
    
    func deleteItem(item: Grocery, completion: @escaping(Bool)->())
    {
        fireStoreGroceryQueries.deleteItem(item: item)
        {
            status in
            completion(status)
        }
    }
}
