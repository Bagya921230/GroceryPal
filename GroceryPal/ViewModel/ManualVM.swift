//
//  ManualVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class ManualVM {
    
    var delegate: ManualViewControllerDelegate?
    let dispatch = DispatchGroup()

    func onLoad()
    {
        FireStoreDataBase.shared.fetchItems()
    }

}

