//
//  RestockListVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class RestockListVM {
    
    var delegate: StorageListViewControllerDelegate?
    let dispatch = DispatchGroup()
    var fireStoreStockQueries = FireStoreStockQueries()

    func onLoad(fireStoreStockQueries: FireStoreStockQueries)
    {
        self.fireStoreStockQueries = fireStoreStockQueries
        fireStoreStockQueries.fetchRestockItems()
    }

}

