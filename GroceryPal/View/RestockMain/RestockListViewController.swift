//
//  RestockListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class RestockListViewController: UIViewController, RestockItemEvents {

    @IBOutlet weak var tableView: UITableView!
    
    var itemList = [StockItem]()
    var selectedItem: StockItem?
    let restockListVM = RestockListVM()
    let fireStoreStockQueries = FireStoreStockQueries()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fireStoreStockQueries.delegateRestockItemEvents = self
        restockListVM.onLoad(fireStoreStockQueries: fireStoreStockQueries)
    }
    
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func restockItemList(restockItemList: [StockItem]) {
        self.itemList = restockItemList
        self.tableView.reloadData()
    }

}

extension RestockListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "itemTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemListTableViewCell else {
            fatalError("The dequed cell is not an instance of ItemListTableViewCell")
        }
        let item = itemList[indexPath.row]
        cell.setUp(restockItem: item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

}
