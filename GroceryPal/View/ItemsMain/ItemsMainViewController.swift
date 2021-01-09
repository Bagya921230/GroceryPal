//
//  ItemsMainViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class ItemsMainViewController: UINavigationController {

    var itemList = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(itemList.count > 0)
        {
           performSegue(withIdentifier: "noItems", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
