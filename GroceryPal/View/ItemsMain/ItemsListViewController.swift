//
//  ItemsListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/31/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemList = [Item]()
    var selectedItem: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.setTextFieldColor(UIColor.init(red: 249, green: 249, blue: 249, alpha: 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "editItem"{
               if let vc = segue.destination as? ItemDetailViewController {
                   vc.selectedItem = selectedItem
                   vc.isEditMode = true
               }
           }
    }

}

extension ItemsListViewController : UITableViewDataSource , UITableViewDelegate{
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
        cell.setUp(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = itemList[indexPath.row]
    }

}
