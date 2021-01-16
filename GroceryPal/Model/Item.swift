//
//  Item.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

protocol ItemEvents {
    func itemList(itemList: [Item])
}

struct Item: Codable {
    var id: String
    var name: String
    var category: String
    var uom: String
    var unitPrice: Double
    var perValue: Double
    var roLevel: Double
    var notes: String
    var image: String
    var barcode: String

    init(name:String, category:String, uom:String, unitPrice:Double, perValue:Double, roLevel:Double, notes:String, image: String, id: String, barcode: String){
        self.name=name
        self.category=category
        self.uom=uom
        self.unitPrice=unitPrice
        self.perValue=perValue
        self.roLevel=roLevel
        self.notes=notes
        self.image=image
        self.id = id
        self.barcode = barcode
    }
}
