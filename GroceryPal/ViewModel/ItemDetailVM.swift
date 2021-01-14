//
//  ItemDetailVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/10/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit


class ItemDetailVM {

    var delegate: ItemDetailViewController?
    var fireStoreQueries = FireStoreItemQueries()

    func onLoad()
    {
        let group = DispatchGroup()

        group.enter()
        FireStoreDataBase.shared.fetchCategories(){(catList) in
            self.delegate?.displayCategories(list: catList)
            group.leave()
        }
        
        group.enter()
        FireStoreDataBase.shared.fetchUOM(){(uomList) in
            self.delegate?.displayUOM(list: uomList)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.delegate?.displayValuesInScreen()
        }
    }
        
    func sendValues(name: String, category: String, uom: String,notes:String,price:String,nonUnitPrice:String,perVal:String, roLevel:String, image: UIImage?, isEditMode: Bool, selectedItem: Item?) -> Bool
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
            
            let imagePath = selectedItem != nil ? selectedItem!.image : ""
            let id = selectedItem != nil ? selectedItem!.id : ""
            
            let item = Item(name: name, category: category, uom: uom, unitPrice: unitPrice, perValue: perValDouble, roLevel: roLevelDouble, notes: notes, image: imagePath, id: id)
                          
            if(isEditMode)
            {
                updateItem(item: item, image: image, completion: { _ in })

            }
            else
            {
                storeItem(item: item, image: image, completion: { _ in })
            }
            return true
        }
        
        return false
    }
    
    func getUnitPrice(selectedUnit: String, price: Double, nonUnitPrice: Double) -> Double
    {
        return selectedUnit == "unit" ? price : nonUnitPrice;
    }
    
    func storeItem(item: Item, image: UIImage?, completion: @escaping(Bool)->())
    {
        fireStoreQueries.addItems(item: item, image: image){ transaction in
                            if(transaction)
                            {
                                self.delegate?.performSuccess()
                                completion(true)
                            }
                            else
                            {
                                self.delegate?.displayError(msg: "Cannot add the item")
                                completion(false)
                            }
         }
    }
    
    func updateItem(item: Item, image: UIImage?, completion: @escaping(Bool)->())
    {
        fireStoreQueries.updateItems(item: item, image: image){ transaction in
                            if(transaction)
                            {
                                self.delegate?.performSuccess()
                                completion(true)
                            }
                            else
                            {
                                self.delegate?.displayError(msg: "Cannot update the item")
                                completion(false)
                            }
         }
    }
    
    func getSelectedDropDownIndex(list: [String], findText: String) -> Int
    {
        if(list.count > 0)
        {
            return list.firstIndex(of: findText)!
        }
        else
        {
            return 0
        }
    }
}
