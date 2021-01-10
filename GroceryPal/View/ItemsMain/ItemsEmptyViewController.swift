//
//  ItemsEmptyViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/31/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

<<<<<<< HEAD:GroceryPal/View/ItemsMain/ItemsMainViewController.swift
class ItemsMainViewController: UINavigationController {
=======
class ItemsEmptyViewController: UIViewController {
>>>>>>> 770865986728e90c530cca48acca6ab6294a1e47:GroceryPal/View/ItemsMain/ItemsEmptyViewController.swift

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
<<<<<<< HEAD:GroceryPal/View/ItemsMain/ItemsMainViewController.swift
    
=======

>>>>>>> 770865986728e90c530cca48acca6ab6294a1e47:GroceryPal/View/ItemsMain/ItemsEmptyViewController.swift
}
