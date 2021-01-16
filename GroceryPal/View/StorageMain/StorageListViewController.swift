//
//  StorageListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit
import iOSDropDown

protocol StorageListViewControllerDelegate {
    func displayCategories(list: [String])
    func displayStatus(list: [String])
    func displayError(msg: String)
    func addSuccess()
}

class StorageListViewController: UIViewController, StorageListViewControllerDelegate, StockItemEvents {

    //MARK: - Outlet
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var statusDropDown: DropDown!
    @IBOutlet weak var tableView: UITableView!
    
    var isEditMode: Bool = false
    let storageListVM = StorageListVM()
    var stockItemList = [StockItem]()
    var filteredStockItemList = [StockItem]()
    var selectedItem: StockItem?
    let fireStoreStockQueries = FireStoreStockQueries()
    var selectedCategory = "All"
    var selectedStatus = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        storageListVM.delegate = self
        fireStoreStockQueries.delegateStockItemEvents = self
        storageListVM.onLoad(fireStoreStockQueries: fireStoreStockQueries)
        handleDropDowns()
        configureNotificationObserver()
    }
    
    private func configureNotificationObserver() {
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.updateWhenNotificationReceived),
        name: Notification.Name(rawValue: "UPDATE_STORAGE"),
        object: nil)
    }
    
    @objc private func updateWhenNotificationReceived(notification: NSNotification){
        print("noti update")
        storageListVM.onLoad(fireStoreStockQueries: fireStoreStockQueries)
    }
    
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
    }
    
    func handleDropDowns()
    {
        categoryDropDown.didSelect{(selectedText , index ,id) in
            self.selectedCategory = selectedText
            self.filterList()
        }
        statusDropDown.didSelect{(selectedText , index ,id) in
            self.selectedStatus = selectedText
            self.filterList()
        }
    }
    
    func filterList() {
        if self.selectedStatus == "All" && self.selectedCategory == "All"{
            self.filteredStockItemList = self.stockItemList
        } else if self.selectedStatus == "All" {
            self.filteredStockItemList = self.stockItemList.filter{ $0.category.contains(self.selectedCategory)}
        } else if self.selectedCategory == "All" {
            self.filteredStockItemList = self.stockItemList.filter{ $0.status.contains(self.selectedStatus)}
        } else {
            self.filteredStockItemList = self.stockItemList.filter{ $0.category.contains(self.selectedCategory) && $0.status.contains(self.selectedStatus)}
        }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tableView.reloadData()
    }
    
    func displayCategories(list: [String]) {
        var catist = list
        catist.insert("All", at: 0)
        let selectedVal = catist[0]
        self.categoryDropDown.optionArray = catist
        self.categoryDropDown.selectedIndex = 0
        self.categoryDropDown.text = selectedVal
    }
    
    func displayStatus(list: [String]) {
        var statList = list
        statList.insert("All", at: 0)
        let selectedVal = statList[0]
        self.statusDropDown.optionArray = statList
        self.statusDropDown.selectedIndex = 0
        self.statusDropDown.text = selectedVal
    }
    
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func addSuccess() {
        
    }
    
    func stockItemList(stockItemList: [StockItem]) {
        self.stockItemList = stockItemList
        self.filteredStockItemList = stockItemList
        tableView.reloadData()
        handleBackgroundView()
    }
    
    func handleBackgroundView() {
           if let vcs = self.navigationController?.viewControllers {
               let previousVC = vcs[0]
               if previousVC is StorageMainViewController {
                   (previousVC as! StorageMainViewController).stockItemList = stockItemList
                   (previousVC as! StorageMainViewController).onLoad()
               }
           }
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueUpdateStorage"{
            if let vc = segue.destination as? UpdateStorageViewController {
                vc.selectedItem = selectedItem
            }
        }
    }

}

extension StorageListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStockItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "storageItemCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StorageItemTableViewCell else {
            fatalError("The dequed cell is not an instance of StorageItemTableViewCell")
        }
        let item = filteredStockItemList[indexPath.row]
        cell.setUp(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = filteredStockItemList[indexPath.row]
        performSegue(withIdentifier: "segueUpdateStorage", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            storageListVM.deleteItem(item: filteredStockItemList[indexPath.row], completion: {
                status in
                      if(!status)
                      {
                          self.displayError(msg: "Cannot delete the item")
                      }
            })
        }
    }
    
}
