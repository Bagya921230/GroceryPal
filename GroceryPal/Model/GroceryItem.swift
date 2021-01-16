//
//  GroceryItem.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

protocol GroceryItemEvents {
    func groceryItemList(itemList: [GroceryItem])
}

struct GroceryItem: Codable {
    var id: String
    var name: String
    var category: String
    var uom: String
    var unitPrice: Double
    var total: Double
    var quantity: Double
    var image: String

    init(name:String, category:String, uom:String, unitPrice:Double, total:Double,id: String, quantity:Double, image:String){
        self.name = name
        self.category = category
        self.uom = uom
        self.unitPrice = unitPrice
        self.total = total
        self.id = id
        self.quantity = quantity
        self.image = image
    }
}

