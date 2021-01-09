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

struct Item {
    var id: String
    var name: String
    
    init(id: String, name:String){
        self.name=name
        self.id=id
    }
}
