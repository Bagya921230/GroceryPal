//
//  NotificationEmptyViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/31/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class NotificationEmptyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
