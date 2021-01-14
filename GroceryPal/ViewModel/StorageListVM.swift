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

    func onLoad()
    {
        FireStoreDataBase.shared.fetchCategories(){(catList) in
            self.delegate?.displayCategories(list: catList)
        }
        
        //FIXME: Get status list
        FireStoreDataBase.shared.fetchUOM(){(uomList) in
            self.delegate?.displayStatus(list: uomList)
        }
    }

}
