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

    func onLoad()
    {
        FireStoreDataBase.shared.fetchCategories(dispatch: dispatch){(catList) in
            self.dispatch.notify(queue: .main, execute: {
                self.delegate?.displayCategories(list: catList)
             })
        }
        
        FireStoreDataBase.shared.fetchStatuses(dispatch: dispatch){(statusList) in
            self.dispatch.notify(queue: .main, execute: {
                self.delegate?.displayStatus(list: statusList)
            })
        }
    }

}
