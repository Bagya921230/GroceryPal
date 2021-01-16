//
//  FireStoreStatisticsQueries.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

class FireStoreStatisticsQueries {

    let userId = UserDefaults.standard.string(forKey: "userId")!
    var delegateStockItemEvents: StockItemEvents?
    var delegateRestockItemEvents: RestockItemEvents?

    
    func fetchRestockItems(completion: @escaping (Double) -> Void)
    {

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").whereField("status", isEqualTo: "restock").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
                completion(0)
            }
            else {
                completion(Double(querySnapshot!.count))
            }
        }
    }
    
    func fetchActiveItems(completion: @escaping (Double) -> Void)
    {

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").whereField("status", isEqualTo: "active").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
                completion(0)
            }
            else {
                completion(Double(querySnapshot!.count))
            }
        }
    }
    
    func fetchExpiredItems(completion: @escaping (Double) -> Void)
    {

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").whereField("status", isEqualTo: "expired").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
                completion(0)
            }
            else {
                completion(Double(querySnapshot!.count))
            }
        }
    }
    
    func fetchCategoryUsage(completion: @escaping (Dictionary<String, Double>) -> Void)
    {
        var categoryUsage = Dictionary<String, Double>()

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("storage").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
                completion(categoryUsage)
            }
            else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    do
                    {
                        let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                        var item = try JSONDecoder().decode(StockItem.self, from: jsonObj)
                        item.id = document.documentID
        
                        let usedPercentage = (item.initialQty - item.quantity) / item.initialQty * 100
                        
                        if categoryUsage[item.category] != nil
                        {
                            let usedPercentageAvg = categoryUsage[item.category]! + usedPercentage / 2
                            categoryUsage[item.category] = usedPercentageAvg
                        }
                        else
                        {
                            categoryUsage[item.category] = usedPercentage
                        }
                    }
                    catch
                    {
                        completion(categoryUsage)
                    }
                }
                completion(categoryUsage)
            }
        }
    }
}
