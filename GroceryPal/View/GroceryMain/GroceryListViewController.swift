//
//  GroceryListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

protocol GroceryListViewControllerDelegate {
    func getCreatedList(grocery: Grocery)
    func addNewItem()
    func displayError(msg: String)
}

class GroceryListViewController: UIViewController, GroceryListViewControllerDelegate, GroceryEvent, GroceryItemEvents, RestockItemEvents {
    
    
    var grocery: Grocery?
    let groceryListVM = GroceryListVM()
    var groceryItemList = [GroceryItem]()
    var restockList = [StockItem]()
    let fireStoreGroceryQueries = FireStoreGroceryQueries()
    
    //MARK: - Outlets
    @IBOutlet weak var autoTableView: UITableView!
    @IBOutlet weak var newListTableView: UITableView!
    @IBOutlet var autoTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var newTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var detailView: UIView!
    
    //MARK: - Actions
    @IBAction func addItemAction(_ sender: Any) {
        performSegue(withIdentifier: "segueAddItemToGrocery", sender: nil)
    }
    
    @IBAction func newListAction(_ sender: Any) {
        performSegue(withIdentifier: "segueNewList", sender: nil)
    }
    @IBAction func shareAction(_ sender: Any) {
        if let grocery = self.grocery {
            groceryListVM.deleteItem(item: grocery, completion: {
                status in
                      if(!status)
                      {
                          self.displayError(msg: "Cannot delete the item")
                      }else {
                        self.groceryItemList = []
                        self.newListTableView.reloadData()
                        self.groceryListVM.getGroceryList(groceryId: self.grocery!.id, fireStoreGroceryQueries: self.fireStoreGroceryQueries)
                }
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fireStoreGroceryQueries.delegateGroceryEvent = self
        fireStoreGroceryQueries.delegateRestockItemEvents = self
        fireStoreGroceryQueries.delegateGroceryItemEvents = self
        groceryListVM.onLoad(fireStoreGroceryQueries: fireStoreGroceryQueries)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groceryListVM.onLoad(fireStoreGroceryQueries: fireStoreGroceryQueries)
    }
    
    override func viewDidLayoutSubviews() {
        autoTableView.frame.size = autoTableView.contentSize
        autoTableViewHeightConstraint.constant = autoTableView.frame.height
        newListTableView.frame.size = newListTableView.contentSize
        newTableViewHeightConstraint.constant = newListTableView.frame.height
    }
    
    private func updateTableViewHeight() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Change `2.0` to the desired number of seconds.
            self.autoTableViewHeightConstraint.constant = self.autoTableView.contentSize.height
            self.newTableViewHeightConstraint.constant = self.newListTableView.contentSize.height

        }
    }
    
    func configureUI() {
        autoTableView.dataSource = self
        autoTableView.delegate = self
        autoTableView.allowsSelection = true
        autoTableView.separatorStyle = .none
        newListTableView.dataSource = self
        newListTableView.delegate = self
        newListTableView.allowsSelection = true
        newListTableView.separatorStyle = .none
        newListTableView.estimatedRowHeight = 100
        autoTableView.estimatedRowHeight = 100
    }
    
    func getCreatedList(grocery: Grocery) {
        self.grocery = grocery
        listName.text = grocery.name
        total.text = "LKR 0.00"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueNewList"{
            if let vc = segue.destination as? NewGroceryListViewController {
                vc.delegate = self
            }
        }
        if segue.identifier == "segueAddItemToGrocery"{
            if let vc = segue.destination as? AddItemToGroceryViewController {
                vc.delegateGrocery = self
                vc.list = self.grocery
            }
        }
    }
    
    func groceryEvent(groceryList: [Grocery]) {
        if (groceryList.count > 0){
            detailView.isHidden = true
            self.grocery = groceryList[0]
            listName.text = self.grocery?.name
            total.text = Common.getFormattedDecimalString(value: Common.getFormattedDecimalDouble(value: self.grocery?.total ?? 0))
            groceryListVM.getGroceryList(groceryId: self.grocery!.id, fireStoreGroceryQueries: fireStoreGroceryQueries)
            newButton.isHidden = true
        } else {
            detailView.isHidden = false
            newButton.isHidden = false
        }
    }
    
    func groceryItemList(itemList: [GroceryItem]) {
        self.groceryItemList = itemList
        if (itemList.count > 0) {
            itemCount.text = String(itemList.count)+" "+(itemList.count < 2 ? "item" : "items")
        }
        self.newListTableView.reloadData()
        updateTableViewHeight()
    }
    
    func restockItemList(restockItemList: [StockItem]) {
        self.restockList = restockItemList
        self.autoTableView.reloadData()
        updateTableViewHeight()
    }
    
    func addNewItem() {
        groceryListVM.onLoad(fireStoreGroceryQueries: fireStoreGroceryQueries)
    }
    
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
}

extension GroceryListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case autoTableView:
            return restockList.count
        case newListTableView:
            return groceryItemList.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case autoTableView:
            let cellIdentifier = "groceryTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryItemTableViewCell else {
                fatalError("The dequed cell is not an instance of GroceryItemTableViewCell")
            }
            let item = restockList[indexPath.row]
            cell.setUp(item: item)
            return cell
        case newListTableView:
            let cellIdentifier = "groceryNewTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryNewItemTableViewCell else {
                fatalError("The dequed cell is not an instance of GroceryNewItemTableViewCell")
            }
            let item = groceryItemList[indexPath.row]
            cell.setUp(item: item)
            return cell
        default:
            let cellIdentifier = "groceryTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryItemTableViewCell else {
                fatalError("The dequed cell is not an instance of GroceryItemTableViewCell")
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch tableView {
        case autoTableView:
            return
        case newListTableView:
            if (editingStyle == .delete) {
                groceryListVM.deleteGroceryItem(item: groceryItemList[indexPath.row], listId: self.grocery?.id ?? "" , completion: {
                    status in
                          if(!status)
                          {
                              self.displayError(msg: "Cannot delete the item")
                          } else {
                            self.total.text = "LKR 0.00"
                    }
                })
            }
        default:
            return
        }
        
    }
}
