//
//  UpdateStorageVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class UpdateStorageVM {
    
    var delegate: UpdateStorageViewControllerDelegate?
    let dispatch = DispatchGroup()
    var fireStoreStockQueries = FireStoreStockQueries()

    func sendValues(item: StockItem , newQtyVal: Double) -> Bool
    {
        let quantity = Common.getFormattedDecimalDouble(value:newQtyVal)
                    
        updateStockItem(item: item, newQty: quantity)
        return true
    }
    
    func getUnitPrice(selectedUnit: String, price: Double, nonUnitPrice: Double) -> Double
    {
        return selectedUnit == "unit" ? price : nonUnitPrice;
    }
    
    func updateStockItem(item: StockItem, newQty: Double)
    {
        fireStoreStockQueries.updateStockItem(item: item, newQty : newQty){ transaction in
            if(transaction)
            {
                self.delegate?.addSuccess()
            }
            else
            {
                self.delegate?.displayError(msg: "Cannot update the item")
            }
         }
    }
    

}

