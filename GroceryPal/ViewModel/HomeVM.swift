//
//  HomeVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation


class HomeVM {
    
    var fireStoreNotificationQueries = FireStoreNotificationQueries()
    var fireStoreStockQueries = FireStoreStockQueries()
    
    func onLoad(fireStoreQueries: FireStoreItemQueries, fireStoreStockQueries: FireStoreStockQueries)
    {
        fireStoreQueries.fetchItems()
        fireStoreStockQueries.fetchStockItems()
        fireStoreStockQueries.fetchRestockItems()
    }
    
    func sendValues(id: String, itemName: String, quantity: Double,uom: String, expDate: String, type: String, message: String, title: String, stockItemId: String) -> Bool
    {
        
        let notiItem = NotificationItem(id: "", itemName: itemName, quantity: quantity, uom: uom, expDate: expDate, type: type, message: message, title: title)
                    
        storeNotification(item: notiItem, stockItemId: stockItemId, type: type)
        return true
    }
    
    func storeNotification(item: NotificationItem, stockItemId: String, type: String)
    {
        fireStoreNotificationQueries.addNotification(notiItem: item, stockItemId: stockItemId,type: type){ transaction in
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

}
