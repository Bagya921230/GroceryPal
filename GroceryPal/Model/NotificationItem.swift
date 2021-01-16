//
//  NotificationItem.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

protocol NotificationItemEvents {
    func notificationList(notiList: [NotificationItem])
}

struct NotificationItem: Codable {
    var id: String
    var itemName: String
    var quantity: Double
    var uom: String
    var expDate: String
    var type: String
    var message: String
    var title: String
    
    init(id: String, itemName: String, quantity: Double,uom: String, expDate: String, type: String, message: String, title: String){
        self.id = id
        self.itemName = itemName
        self.quantity = quantity
        self.uom = uom
        self.expDate = expDate
        self.type = type
        self.message = message
        self.title = title
    }
}
