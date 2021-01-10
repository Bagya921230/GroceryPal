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
    
    func sendValues(name: String, category: String, uom: String,notes:String,price:String,nonUnitPrice:String,perVal:String, roLevel:String, image: String) -> Bool
    {
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the item name.")
        }
        
        else if uom == "unit" && price.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the price.")
        }
        
        else if uom != "unit" && nonUnitPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the price.")
        }
        
        else if uom != "unit" && perVal.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the per unit value.")
        }
        
        else
        {
            let priceDouble =  NSString(string: price).doubleValue
            let nonUnitPriceDouble =  NSString(string: nonUnitPrice).doubleValue
            
            let roLevelDouble =  Common.getFormattedDecimalDouble(value:NSString(string: roLevel).doubleValue)
            let perValDouble =  Common.getFormattedDecimalDouble(value:NSString(string: perVal).doubleValue)
            let unitPrice = Common.getFormattedDecimalDouble(value: self.getUnitPrice(selectedUnit: uom, price: priceDouble, nonUnitPrice: nonUnitPriceDouble));
            
            let item = Item(name: name, category: category, uom: uom, unitPrice: unitPrice, perValue: perValDouble, roLevel: roLevelDouble, notes: notes, image: image)
                        
            storeItem(item: item, completion: { _ in })
            return true
        }
        
        return false
    }
    
    func getUnitPrice(selectedUnit: String, price: Double, nonUnitPrice: Double) -> Double
    {
        return selectedUnit == "unit" ? price : nonUnitPrice;
    }
    
    func storeItem(item: Item, completion: @escaping(Bool)->())
    {
        let dispatch = DispatchGroup()
        FireStoreDataBase.shared.addItems(item: item, dispatch: dispatch){ transaction in
                          dispatch.notify(queue: .main, execute: {
                                   
                            if(transaction)
                            {
                                self.delegate?.addSuccess()
                                completion(true)
                            }
                            else
                            {
                                self.delegate?.displayError(msg: "Cannot add the item")
                                completion(true)
                            }
                 })
         }
    }
}
