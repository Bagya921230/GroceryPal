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
    
    func addStockItems(item: StockItem, completed: @escaping (Bool) -> Void)
    {
        
        let docRef = FireStoreDataBase.shared.firebaseDb.collection("user").document().collection("storage").document()
        do {
            let jsonData = try item.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["id"] = docRef.documentID
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").document(docRef.documentID).setData(dictionary)
            { err in
                if let err = err {
                    print("Error adding item: \(err)")
                    completed(false)
                } else {
                    print("Item data successfully written!")
                    completed(true)
                }
            }
        } catch{
            completed(false)
        }
        
    }

}

