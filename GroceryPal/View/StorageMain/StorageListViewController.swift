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

class StorageListViewController: UIViewController, StorageListViewControllerDelegate {

    //MARK: - Outlet
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var statusDropDown: DropDown!
    @IBOutlet weak var tableView: UITableView!
    
    var isEditMode: Bool = false
    let storageListVM = StorageListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        storageListVM.delegate = self
        storageListVM.onLoad()
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func displayCategories(list: [String]) {
        let selectedVal = list[0]
        self.categoryDropDown.optionArray = list
        self.categoryDropDown.selectedIndex = 0
        self.categoryDropDown.text = selectedVal
    }
    
    func displayStatus(list: [String]) {
        let selectedVal = list[0]
        self.statusDropDown.optionArray = list
        self.statusDropDown.selectedIndex = 0
        self.statusDropDown.text = selectedVal
    }
    
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func addSuccess() {
        
    }

}

extension StorageListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "storageItemCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StorageItemTableViewCell else {
            fatalError("The dequed cell is not an instance of StorageItemTableViewCell")
        }
        
        if (indexPath.row == 1) {
           cell.setUp(name: "Coconut Oil 500ml", image: UIImage(named: "temp")!, quantity: "25", date: "02/01/2021", level: "100ml", expired: true, outOfStock: false)
        } else if (indexPath.row == 2) {
           cell.setUp(name: "Coconut Oil 500ml", image: UIImage(named: "temp")!, quantity: "25", date: "02/01/2021", level: "100ml", expired: false, outOfStock: true)
        } else {
            cell.setUp(name: "Coconut Oil 500ml", image: UIImage(named: "temp")!, quantity: "25", date: "02/01/2021", level: "100ml", expired: false, outOfStock: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueUpdateStorage", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
