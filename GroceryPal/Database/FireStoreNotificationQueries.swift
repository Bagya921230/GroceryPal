//
//  FireStoreNotificationQueries.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/15/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class FireStoreNotificationQueries {
    
    let userId = UserDefaults.standard.string(forKey: "userId")!
    var delegateStockNotificationEvents: NotificationItemEvents?
    var fireStoreStockQueries = FireStoreStockQueries()
    func fetchNotifications(){
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("notification").addSnapshotListener { (querySnapshot, error) in
            var notificationList = [NotificationItem]()
            guard let documents = querySnapshot?.documents else {
                self.delegateStockNotificationEvents?.notificationList(notiList: notificationList)
                return
            }
            _ = documents.map { queryDocumentSnapshot -> Void in
            
            do {
            let data = queryDocumentSnapshot.data()
             
            let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
            var item = try JSONDecoder().decode(NotificationItem.self, from: jsonObj)
            item.id = queryDocumentSnapshot.documentID
            notificationList.append(item)
            }
            catch{
                self.delegateStockNotificationEvents?.notificationList(notiList: notificationList)
            }
        }

        self.delegateStockNotificationEvents?.notificationList(notiList: notificationList)
        }
    }
    
    func addNotification(notiItem: NotificationItem,stockItemId: String,type: String, completed: @escaping (Bool) -> Void)
    {
        
        let docRef = FireStoreDataBase.shared.firebaseDb.collection("user").document().collection("notification").document()
        do {
            let jsonData = try notiItem.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["id"] = docRef.documentID
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("notification").document(docRef.documentID).setData(dictionary)
            { err in
                if let err = err {
                    print("Error adding item: \(err)")
                    completed(false)
                } else {
                    FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").document(stockItemId).updateData(["status":type])
                    { err in
                        if let err = err {
                            print("Error updating item: \(err)")
                            completed(false)
                        } else {
                            completed(true)
                        }
                    }
                }
            }
        } catch{
            completed(false)
        }
        
    }
    
    func deleteItem(item: NotificationItem, completion: @escaping(Bool)->())
    {
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("notification").document(item.id).delete() { err in
            if let err = err {
                print("Error removing item: \(err)")

                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
