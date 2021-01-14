//
//  HomeVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation


class HomeVM {
    
    func onLoad(fireStoreQueries: FireStoreItemQueries)
    {
        fireStoreQueries.fetchItems()
    }

}
