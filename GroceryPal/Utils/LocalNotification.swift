//
//  Notification.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit

class LocalNotification {
    
    static func scheduleLocalNotification(type: String, item: StockItem,mins: Int) {
        let content = UNMutableNotificationContent()
        
        if (type == "expired") {
            content.title = "Expired"
            if item.uom == "unit" {
                content.body = "\(item.name) \nExpiry Date \(item.expDate)\nAffected Quantity \(item.quantity)"
            } else {
                content.body = "\(item.name) \nExpiry Date \(item.expDate)\nAffected Quantity \(item.quantity)\(item.uom)"

            }
        } else {
            content.title = "Restock needed"
            if item.uom == "unit" {
                content.body = "\(item.name) \nAvailable Quantity \(item.quantity)"
            } else {
                content.body = "\(item.name) \nAvailable Quantity \(item.quantity)\(item.uom)"

            }
        }
        content.sound = UNNotificationSound.default
        do {
            let jsonData = try item.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["type"] = type
            content.userInfo = dictionary
        } catch {
            
        }
        var adding = mins
        if mins == 0 {
            adding = 1
        }
        let yourDate = Calendar.current.date(byAdding: .minute, value: adding, to: Date())!
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval:
            yourDate.timeIntervalSinceNow, repeats: false)
        let uuid = UUID().uuidString
        let request = UNNotificationRequest.init(identifier: uuid, content:
            content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}
