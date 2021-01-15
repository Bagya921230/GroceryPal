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

protocol RestockItemEvents {
    func restockItemList(restockItemList: [StockItem])
}

struct StockItem: Codable {
    var id: String
    var name: String
    var category: String
    var uom: String
    var unitPrice: Double
    var perValue: Double
    var expDate: String
    var quantity: Double
    var notes: String
    var roLevel: Double
    var status: String
    var image: String
    var initialQty: Double
    var addedDate: String
    
    init(name:String, category:String, uom:String, unitPrice:Double, perValue:Double, expDate:String, quantity: Double, id: String, notes: String, roLevel: Double, status: String, image: String, initQty: Double, addedDate: String){
        self.name = name
        self.category = category
        self.uom = uom
        self.unitPrice = unitPrice
        self.perValue = perValue
        self.expDate = expDate
        self.quantity = quantity
        self.id = id
        self.notes = notes
        self.roLevel = roLevel
        self.status = status
        self.image = image
        self.initialQty = initQty
        self.addedDate = addedDate
    }
}
