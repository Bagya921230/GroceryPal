//
//  NotificationListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/31/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class NotificationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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

}

extension NotificationListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "notificationCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NotificationTableViewCell else {
            fatalError("The dequed cell is not an instance of NotificationTableViewCell")
        }
        if (indexPath.row == 1) {
            cell.setUp(name: "Yoghurt", qty: "3", msg: "Expired on 02/12/2020", subMsg: "Affected Qty",expired: true, outOfStock: false)
        } else if (indexPath.row == 2) {
            cell.setUp(name: "Eggs", qty: "2", msg: "Restock needed", subMsg: "Available Qty",expired: false, outOfStock: true)
        } else {
            cell.setUp(name: "Fresh Milk 500ml", qty: "2", msg: "Going to expire soon", subMsg: "Affected Qty",expired: false, outOfStock: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
}

