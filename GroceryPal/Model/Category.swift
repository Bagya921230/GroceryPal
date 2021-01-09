//
//  category.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/3/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

struct Category {
    var id: String
    var name: String
    
    init(id: String, name:String){
        self.name=name
        self.id=id
    }
}

