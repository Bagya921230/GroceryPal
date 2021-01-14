//
//  StockItem.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/13/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

protocol StockItemEvents {
    func stockItemList(stockItemList: [StockItem])
}

struct StockItem: Codable {
    var name: String
    var category: String
    var unitPrice: Double
    var perValue: Double
    var expDate: String
    var quantity: Double
    
    init(name:String, category:String, unitPrice:Double, perValue:Double, expDate:String, quantity: Double, id: String){
        self.name = name
        self.category = category
        self.unitPrice = unitPrice
        self.perValue = perValue
        self.expDate = expDate
        self.quantity = quantity
    }
}
