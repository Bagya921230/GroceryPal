//
//  NotificationsViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, NotificationItemEvents {
    
    @IBOutlet weak var emptyContainer: UIView!
    
    @IBOutlet weak var listContainerView: UIView!
    var notificationList = [NotificationItem]()
    let notificationListVM = NotificationListVM()
    let fireStoreNotificationQueries = FireStoreNotificationQueries()
    var isEmpty: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        fireStoreNotificationQueries.delegateStockNotificationEvents = self
        notificationListVM.onLoad(fireStoreNotificationQueries: fireStoreNotificationQueries)
    }
    
    func onLoad()
    {
        if(notificationList.count == 0){
           showEmptyView()
        } else {
           showListView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func showEmptyView() {
        emptyContainer.alpha = 1
        listContainerView.alpha = 0
    }
    
    func showListView() {
        emptyContainer.alpha = 0
        listContainerView.alpha = 1
    }

    func notificationList(notiList: [NotificationItem]) {
        notificationList = notiList
    }
    
}
