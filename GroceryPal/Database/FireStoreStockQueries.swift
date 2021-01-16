//
//  FireStoreStockQueries.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class FireStoreStockQueries {
    
    let userId = UserDefaults.standard.string(forKey: "userId")!
    var delegateStockItemEvents: StockItemEvents?
    var delegateRestockItemEvents: RestockItemEvents?
    
    func fetchStockItems()
    {

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").addSnapshotListener { (querySnapshot, error) in
          
            var itemList = [StockItem]()

            guard let documents = querySnapshot?.documents else {
            self.delegateStockItemEvents?.stockItemList(stockItemList: itemList)
            return
           }

            _ = documents.map { queryDocumentSnapshot -> Void in
                
                do {
                let data = queryDocumentSnapshot.data()
                 
                let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                var item = try JSONDecoder().decode(StockItem.self, from: jsonObj)
                item.id = queryDocumentSnapshot.documentID
                itemList.append(item)
                }
                catch{
                    self.delegateStockItemEvents?.stockItemList(stockItemList: itemList)
                }
            }
        
            self.delegateStockItemEvents?.stockItemList(stockItemList: itemList)
        }
    }
    
    func addStockItems(item: StockItem, completion: @escaping(Any)->())
    {
        
        let docRef = FireStoreDataBase.shared.firebaseDb.collection("user").document().collection("storage").document()
        do {
            let jsonData = try item.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["id"] = docRef.documentID
            if (item.quantity <= item.roLevel) {
                dictionary["status"] = "restock"
            } else {
                dictionary["status"] = "active"
            }
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").document(docRef.documentID).setData(dictionary)
            { err in
                if let err = err {
                    print("Error adding item: \(err)")
                    completion("err")
                } else {
                    print("Item data successfully written!")
                    var stockItem = item
                    stockItem.id = docRef.documentID
                    completion(stockItem)
                }
            }
        } catch{
            completion("err")
        }
        
    }
    
    func updateStockItem(item: StockItem, newQty: Double, completed: @escaping (Bool) -> Void)
    {
        do
        {
            let jsonData = try item.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["id"] = item.id
            dictionary["quantity"] = newQty
            if (newQty <= item.roLevel) {
                dictionary["status"] = "restock"
                LocalNotification.scheduleLocalNotification(type: "restock", item: item, mins: 1)
            } else {
                dictionary["status"] = "active"
            }
            
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").document(item.id).setData(dictionary,merge: true)
            { err in
                if let err = err {
                    print("Error updating item: \(err)")
                    completed(false)
                } else {
                    completed(true)
                }
            }
            
        } catch {
            completed(false)
        }
    }
    

    func fetchRestockItems()
    {

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").whereField("status", isEqualTo: "restock").addSnapshotListener { (querySnapshot, error) in
          
            var itemList = [StockItem]()

            guard let documents = querySnapshot?.documents else {
            self.delegateRestockItemEvents?.restockItemList(restockItemList: itemList)
            return
           }

            _ = documents.map { queryDocumentSnapshot -> Void in
                
                do {
                let data = queryDocumentSnapshot.data()
                 
                let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                var item = try JSONDecoder().decode(StockItem.self, from: jsonObj)
                item.id = queryDocumentSnapshot.documentID
                itemList.append(item)
                }
                catch{
                    self.delegateRestockItemEvents?.restockItemList(restockItemList: itemList)
                }
            }
        
            self.delegateRestockItemEvents?.restockItemList(restockItemList: itemList)
        }
    }
    
    func deleteItem(item: StockItem, completion: @escaping(Bool)->())
    {
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").document(item.id).delete() { err in
            if let err = err {
                print("Error removing item: \(err)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

