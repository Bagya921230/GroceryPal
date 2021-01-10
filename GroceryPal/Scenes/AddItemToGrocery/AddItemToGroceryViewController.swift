//
//  AddItemToGroceryViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class AddItemToGroceryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
        style: .plain,
        target: self,
        action: #selector(onDoneAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#008891ff")

    }
    
    @objc
    func onDoneAction() {
        print("done action")
    }
}
