//
//  NotificationListVM.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class NotificationListVM {
    let dispatch = DispatchGroup()
    var fireStoreNotificationQueries = FireStoreNotificationQueries()

    func onLoad(fireStoreNotificationQueries: FireStoreNotificationQueries)
    {
        self.fireStoreNotificationQueries = fireStoreNotificationQueries
        fireStoreNotificationQueries.fetchNotifications()
    }
    
    func sendValues(id: String, itemName: String, quantity: Double,uom: String, expDate: String, type: String, message: String, title: String, stockItemId: String) -> Bool
    {
        
        let stockItem = NotificationItem(id: "", itemName: itemName, quantity: quantity, uom: uom, expDate: expDate, type: type, message: message, title: title)
                    
        storeNotification(item: stockItem, stockItemId: stockItemId, type: type)
        return true
    }
    
    func storeNotification(item: NotificationItem, stockItemId: String, type: String)
    {
        fireStoreNotificationQueries.addNotification(notiItem: item, stockItemId: stockItemId, type: type){ transaction in
            if(transaction)
            {
                print("Stored notfication")
            }
            else
            {
                print("Cannot add the item")
            }
         }
    }
    
    func deleteItem(item: NotificationItem, completion: @escaping(Bool)->())
    {
        fireStoreNotificationQueries.deleteItem(item: item)
        {
            status in
            completion(status)
        }
    }
}

