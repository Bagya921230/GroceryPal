//
//  StorageListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class StorageListViewController: UIViewController {

    @IBOutlet weak var categoryDropdown: UIView!
    @IBOutlet weak var statusDropdown: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        categoryDropdown.addBorderColor()
        statusDropdown.addBorderColor()
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
