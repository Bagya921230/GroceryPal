//
//  StorageViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class StorageMainViewController: UIViewController,ItemEvents, StockItemEvents {

    // MARK: - Outlet
    @IBOutlet weak var emptyContainer: UIView!
    @IBOutlet weak var listContainerView: UIView!
    @IBOutlet weak var addNewBtn: UIButton!
    let fireStoreQueries = FireStoreItemQueries()
    let fireStoreStockQueries = FireStoreStockQueries()
    var itemList = [Item]()
    var stockItemList = [StockItem]()
    let homeVM = HomeVM()
    
    // MARK: - Actions
    @IBAction func addToStorageAction(_ sender: Any) {
        performSegue(withIdentifier: "segueAddToStorage", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireStoreQueries.delegateItemEvents = self
        fireStoreStockQueries.delegateStockItemEvents = self
        homeVM.onLoad(fireStoreQueries: fireStoreQueries, fireStoreStockQueries: fireStoreStockQueries)
    }
    
    func onLoad()
    {
        if(self.stockItemList.count == 0){
           showEmptyView()
        } else {
           showListView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.tintColor = UIColor.themeColor()
    }
    
    func showEmptyView() {
        emptyContainer.alpha = 1
        listContainerView.alpha = 0
        addNewBtn.isHidden = true
    }
    
    func showListView() {
        emptyContainer.alpha = 0
        listContainerView.alpha = 1
        addNewBtn.isHidden = false
    }

    func itemList(itemList: [Item]) {
        self.itemList = itemList
    }
    
    func stockItemList(stockItemList: [StockItem]) {
        self.stockItemList = stockItemList
        onLoad()
    }
}
