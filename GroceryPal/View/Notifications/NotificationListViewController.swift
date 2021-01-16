//
//  NotificationListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/31/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

protocol NotificationListViewControllerDelegate {
    func displayError(msg: String)
}

class NotificationListViewController: UIViewController, NotificationItemEvents, NotificationListViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var notificationList = [NotificationItem]()
    let notificationListVM = NotificationListVM()
    let fireStoreNotificationQueries = FireStoreNotificationQueries()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fireStoreNotificationQueries.delegateStockNotificationEvents = self
        notificationListVM.onLoad(fireStoreNotificationQueries: fireStoreNotificationQueries)
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
    
    func notificationList(notiList: [NotificationItem]) {
        self.notificationList = notiList
        self.tableView.reloadData()
    }
    
    func displayError(msg: String) {
        Common.showAlert(msg: msg, viewController: self)
    }

}

extension NotificationListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "notificationCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NotificationTableViewCell else {
            fatalError("The dequed cell is not an instance of NotificationTableViewCell")
        }
        let item = notificationList[indexPath.row]
        cell.setUp(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            notificationListVM.deleteItem(item: notificationList[indexPath.row], completion: {
                status in
                      if(!status)
                      {
                          self.displayError(msg: "Cannot delete the item")
                      }
            })
        }
    }
    
}

