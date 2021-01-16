//
//  StorageEmptyViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class StorageEmptyViewController: UIViewController,ItemEvents {
    
    @IBOutlet weak var addNewBtn: UIButton!
    let fireStoreQueries = FireStoreItemQueries()
    let fireStoreStockQueries = FireStoreStockQueries()
    var itemList = [Item]()
    let homeVM = HomeVM()

    @IBAction func addToStoreAction(_ sender: Any) {
        if (self.itemList.count == 0) {
            Common.showAlert(msg:"Please create items before adding to storage" , viewController: self)
        } else {
            performSegue(withIdentifier: "segueAddToStore", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireStoreQueries.delegateItemEvents = self
        homeVM.onLoad(fireStoreQueries: fireStoreQueries, fireStoreStockQueries: fireStoreStockQueries)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func itemList(itemList: [Item]) {
        self.itemList = itemList
    }
}
