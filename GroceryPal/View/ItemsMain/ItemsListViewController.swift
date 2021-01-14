//
//  ItemsListViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/10/21.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

protocol ItemsListViewControllerDelegate {
    func displayError(msg: String)
}

class ItemsListViewController: UIViewController, UISearchBarDelegate, ItemsListViewControllerDelegate, ItemEvents {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemList = [Item]()
    var filteredItemList = [Item]()
    var selectedItem: Item?
    let itemListVM = ItemListVM()
    let fireStoreQueries = FireStoreItemQueries()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        itemListVM.delegate = self
        fireStoreQueries.delegateItemEvents = self
        itemListVM.onLoad(fireStoreQueries: fireStoreQueries)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "editItem"{
               if let vc = segue.destination as? ItemDetailViewController {
                   print("xxx ddd",selectedItem)
                   vc.selectedItem = selectedItem
                   vc.isEditMode = true
               }
           }
    }
    
    @objc func onAdd() {
        let storyboard = UIStoryboard(name: "ItemsMain", bundle: nil)
        let itemAddViewController = storyboard.instantiateViewController(withIdentifier: "itemsDetailVC") as! ItemDetailViewController
        self.navigationController?.pushViewController(itemAddViewController, animated: true)
    }

    func configureUI() {

        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.setTextFieldColor(UIColor.init(red: 249, green: 249, blue: 249, alpha: 1))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false
        {
            filteredItemList = itemListVM.filterList(searchText: searchText, itemList: itemList)
        }
        else
        {
            filteredItemList = itemList
        }
        tableView.reloadData()
    }
       
    func displayError(msg: String) {
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func itemList(itemList: [Item]) {
        self.itemList = itemList
        self.filteredItemList = itemList
        tableView.reloadData()
    }

}

extension ItemsListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "itemTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemListTableViewCell else {
            fatalError("The dequed cell is not an instance of ItemListTableViewCell")
        }
        
        let item = filteredItemList[indexPath.row]
        cell.setUp(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = filteredItemList[indexPath.row]
    }
    
    // delete row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            itemListVM.deleteItem(docId: filteredItemList[indexPath.row].id)
        }
    }

}
