//
//  ItemsEmptyViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/10/21.
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
