//
//  CustomNavigationController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/30/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // FIX ME:- later add this in landing nav controller
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
