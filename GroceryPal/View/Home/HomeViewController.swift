//
//  HomeViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,ItemEvents, StockItemEvents , RestockItemEvents{
        
    // MARK: - Outlet
    @IBOutlet weak var storageView: UIView!
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var groceryListView: UIView!
    @IBOutlet weak var restockNeededView: UIView!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var stockItemCount: UILabel!
    @IBOutlet weak var restockItemCount: UILabel!
    
    let homeVM = HomeVM()
    let fireStoreQueries = FireStoreItemQueries()
    let fireStoreStockQueries = FireStoreStockQueries()
    var itemList = [Item]()
    var stockItemList = [StockItem]()
    var restockItemList = [StockItem]()

    // MARK: - Actions
    @IBAction func clickStorage(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
        let nav = self.tabBarController?.viewControllers?[1] as! UINavigationController
        let vc = nav.topViewController as! StorageMainViewController
        vc.isEmpty = stockItemList.count == 0
    }
    
    @IBAction func clickGrocery(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func clickItems(_ sender: Any) {
        performSegue(withIdentifier: "segueItemMain", sender: nil)
    }
    
    @IBAction func clickRestock(_ sender: Any) {
        performSegue(withIdentifier: "segueRestockMain", sender: nil)
    }
    
    @IBAction func clickStatistics(_ sender: Any) {
        performSegue(withIdentifier: "segueStatistics", sender: nil)
    }
    
    @IBAction func clickNotifications(_ sender: Any) {
        performSegue(withIdentifier: "segueNotifications", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireStoreQueries.delegateItemEvents = self
        fireStoreStockQueries.delegateStockItemEvents = self
        fireStoreStockQueries.delegateRestockItemEvents = self
        configureUI()
        homeVM.onLoad(fireStoreQueries: fireStoreQueries, fireStoreStockQueries: fireStoreStockQueries)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.tintColor = UIColor.themeColor()
    }
    
    func configureUI() {
        storageView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        itemsView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        groceryListView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        restockNeededView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        statisticsView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueItemMain"{
            if let vc = segue.destination as? ItemsMainViewController {
                vc.isEmpty = itemList.count == 0
            }
        }
        if segue.identifier == "segueRestockMain"{
            if let vc = segue.destination as? RestockMainViewController {
                vc.isEmpty = restockItemList.count == 0
            }
        }
    }

    @IBAction func onLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "loggedIn")
        let storyboard = UIStoryboard(name: "Landing", bundle: nil)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "landingNavigation")
    }
    
    func itemList(itemList: [Item]) {
        self.itemList = itemList
        itemCount.text = String(itemList.count)+" "+(itemList.count < 2 ? "item" : "items")+" available"
    }
    
    func stockItemList(stockItemList: [StockItem]) {
        self.stockItemList = stockItemList
        stockItemCount.text = String(stockItemList.count)+" "+(stockItemList.count < 2 ? "item" : "items")+" available"
    }
    
    func restockItemList(restockItemList: [StockItem]) {
        self.restockItemList = restockItemList
        restockItemCount.text = String(restockItemList.count)+" "+(restockItemList.count < 2 ? "item" : "items")+" available"
    }
    
}
