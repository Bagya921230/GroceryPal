//
//  UpdateStorageViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/30/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class UpdateStorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
