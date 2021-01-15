//
//  StorageListVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/12/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class StorageListVM {
    
    var delegate: StorageListViewControllerDelegate?
    let dispatch = DispatchGroup()
    var fireStoreStockQueries = FireStoreStockQueries()

    func onLoad(fireStoreStockQueries: FireStoreStockQueries)
    {
        let group = DispatchGroup()

        group.enter()
        FireStoreDataBase.shared.fetchCategories(){(catList) in
            self.delegate?.displayCategories(list: catList)
            group.leave()
        }
        
        group.enter()
        FireStoreDataBase.shared.fetchStatus(){(statusList) in
            self.delegate?.displayStatus(list: statusList)
            group.leave()
        }
        
        self.fireStoreStockQueries = fireStoreStockQueries
        fireStoreStockQueries.fetchStockItems()
    }

}
