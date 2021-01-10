//
//  ItemDetailVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/10/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation


class ItemDetailVM {

    var delegate: ItemDetailViewController?
    let dispatch = DispatchGroup()

    func onLoad()
    {
        FireStoreDataBase.shared.fetchCategories(dispatch: dispatch){(catList) in
            self.dispatch.notify(queue: .main, execute: {
                self.delegate?.displayCategories(list: catList)
             })
        }
        
        FireStoreDataBase.shared.fetchUOM(dispatch: dispatch){(uomList) in
            self.dispatch.notify(queue: .main, execute: {
                self.delegate?.displayUOM(list: uomList)
            })
        }
    }
    
    func sendValues(name: String, category: String, uom: String,notes:String,price:String,nonUnitPrice:String,perVal:String, roLevel:String) -> Bool
    {
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the item name.")
        }
        
        if uom == "unit" && price.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the price.")
        }
        
        if uom != "unit" && nonUnitPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the price.")
        }
        
        if uom != "unit" && perVal.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the per unit value.")
        }
        
        return false
    }
}
