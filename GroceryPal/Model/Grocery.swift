//
//  GroceryList.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

protocol GroceryEvent{
    func groceryEvent(groceryList: [Grocery])
}

struct Grocery: Codable {
    var id: String
    var name: String
    var total: Double
    var itemCount: Int

    init(id: String, name:String, total: Double, itemCount: Int){
        self.id = id
        self.name = name
        self.itemCount = itemCount
        self.total = total
    }
}

