//
//  AddItemToGroceryVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

class AddItemToGroceryVM {
    let dispatch = DispatchGroup()
    var fireStoreGroceryQueries = FireStoreGroceryQueries()
    var delegate: AddItemToGroceryViewControllerDelegate?

    func onLoad(fireStoreQueries: FireStoreItemQueries)
    {
        fireStoreQueries.fetchItems()
    }
    
    func sendValues(name:String, category:String, uom:String, unitPrice:Double,id: String, quantity:String, image:String, list: Grocery, perVal: Double) -> Bool
    {
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the name.")
        }else if quantity.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the quantity.")
        } else {
            let qty = Common.getFormattedDecimalDouble(value:NSString(string: quantity).doubleValue)
            var calc = unitPrice * qty
            if uom == "unit" {
               calc = unitPrice * qty
            } else {
                calc = (unitPrice / perVal ) * qty
            }
            let total = Common.getFormattedDecimalDouble(value: calc )
            let item = GroceryItem(name: name, category: category, uom: uom, unitPrice: unitPrice, total: total, id: "", quantity: qty, image: image)
                        
            storeGroceryItem(item: item, list: list)
            return true
        }
        return false
    }
    
    func storeGroceryItem(item: GroceryItem, list: Grocery)
    {
        fireStoreGroceryQueries.createGroceryItem(grocery: item, list: list ){ result in
            if result {
                let total = item.total
                var grocery = list
                grocery.total += total
                grocery.itemCount += 1
                self.updateGrocery(item: grocery)
            } else {
                print("Cannot add the grocery")
            }
         }
        
    }
    
    func updateGrocery(item: Grocery)
    {
        fireStoreGroceryQueries.updateGrocery(item: item){ result in
            if result {
                self.delegate?.addSuccess()
            } else {
                print("Cannot add the grocery")
            }
         }
        
    }
    
}
