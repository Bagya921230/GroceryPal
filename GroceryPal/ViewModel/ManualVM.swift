//
//  ManualVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class ManualVM {
    
    var delegate: ManualViewControllerDelegate?
    let dispatch = DispatchGroup()
    var fireStoreStockQueries = FireStoreStockQueries()

    func onLoad(fireStoreQueries: FireStoreItemQueries)
    {
        fireStoreQueries.fetchItems()
    }
    
    func sendValues(name: String, category: String, uom: String, notes:String, unitPrice: String, nonUnitPrice:String, perVal:String, roLevel:Double, quantity: String, expDate: String, image: String) -> Bool
    {
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the item name.")
        }
        
        else if uom == "unit" && unitPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the price.")
        }
        
        else if uom != "unit" && nonUnitPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the price.")
        }
        
        else if uom != "unit" && perVal.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the per unit value.")
        }
            
        else if expDate.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please select a expiry date.")
        }
            
        else if quantity.trimmingCharacters(in: .whitespaces).isEmpty {
            delegate?.displayError(msg: "Please enter the quantity")
        }
        
        else
        {
            let priceDouble =  NSString(string: unitPrice).doubleValue
            let nonUnitPriceDouble =  NSString(string: nonUnitPrice).doubleValue
            
            let roLevelDouble =  roLevel
            let perValDouble =  Common.getFormattedDecimalDouble(value:NSString(string: perVal).doubleValue)
            let unitPrice = Common.getFormattedDecimalDouble(value: self.getUnitPrice(selectedUnit: uom, price: priceDouble, nonUnitPrice: nonUnitPriceDouble))
            let quantity = Common.getFormattedDecimalDouble(value:NSString(string: quantity).doubleValue)
            
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            let addedDate = dateformatter.string(from: Date())
            
            let stockItem = StockItem(name: name, category: category, uom: uom, unitPrice: unitPrice, perValue: perValDouble, expDate: expDate, quantity: quantity, id: "", notes: notes, roLevel: roLevelDouble, status: "active", image: image, initQty: quantity, addedDate: addedDate)
                        
            storeItem(item: stockItem)
            return true
        }
        
        return false
    }
    
    func getUnitPrice(selectedUnit: String, price: Double, nonUnitPrice: Double) -> Double
    {
        return selectedUnit == "unit" ? price : nonUnitPrice;
    }
    
    func storeItem(item: StockItem)
    {
        fireStoreStockQueries.addStockItems(item: item){ item in
            if(item as? StockItem ?? nil != nil)
                            {
                                self.delegate?.addSuccess(item: item as! StockItem)
                            }
                            else
                            {
                                self.delegate?.displayError(msg: "Cannot add the item")
                            }
         }
    }

}

