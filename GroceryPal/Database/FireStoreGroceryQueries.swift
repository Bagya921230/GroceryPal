//
//  FireStoreGroceryQueries.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class FireStoreGroceryQueries {
    
    let userId = UserDefaults.standard.string(forKey: "userId")!
    var delegateRestockItemEvents: RestockItemEvents?
    var delegateGroceryItemEvents: GroceryItemEvents?
    var delegateGroceryEvent: GroceryEvent?
    
    func createGroceryList(grocery: Grocery, completion: @escaping(Any)->()) {
        
        let docRef = FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document()
        do {
            let jsonData = try grocery.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["id"] = docRef.documentID
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(docRef.documentID).setData(dictionary)
            { err in
                if let err = err {
                    print("Error adding item: \(err)")
                    completion("err")
                } else {
                    print("Grocery data successfully written!")
                    var grocery = grocery
                    grocery.id = docRef.documentID
                    completion(grocery)
                }
            }
        } catch{
            completion("err")
        }
        
    }
    
    func createGroceryItem(grocery: GroceryItem, list: Grocery, completed: @escaping (Bool) -> Void) {
        
        let docRef = FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(list.id).collection("list").document()
        do {
            let jsonData = try grocery.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            dictionary["id"] = docRef.documentID
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(list.id).collection("list").document(docRef.documentID).setData(dictionary)
            { err in
                if let err = err {
                    print("Error adding item: \(err)")
                    completed(false)
                } else {
                    print("Grocery item successfully written!")
                    completed(true)
                }
            }
        } catch{
            completed(false)
        }
        
    }
    
    func updateGrocery(item: Grocery, completed: @escaping (Bool) -> Void) {
        do
        {
            let jsonData = try item.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let dictionary = json as! [String : Any]
            FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(item.id).setData(dictionary,merge: true)
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
    
    func fetchGrocery() {
           FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").addSnapshotListener { (querySnapshot, error) in
             
               var itemList = [Grocery]()

               guard let documents = querySnapshot?.documents else {
                self.delegateGroceryEvent?.groceryEvent(groceryList: itemList)
               return
              }

               _ = documents.map { queryDocumentSnapshot -> Void in
                   
                   do {
                   let data = queryDocumentSnapshot.data()
                    
                   let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                   var item = try JSONDecoder().decode(Grocery.self, from: jsonObj)
                   item.id = queryDocumentSnapshot.documentID
                   itemList.append(item)
                   }
                   catch{
                       self.delegateGroceryEvent?.groceryEvent(groceryList: itemList)
                   }
               }
           
               self.delegateGroceryEvent?.groceryEvent(groceryList: itemList)
           }
       }
    
    func fetchGroceryItemList(groceryListId: String) {
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(groceryListId).collection("list").addSnapshotListener { (querySnapshot, error) in
          
            var itemList = [GroceryItem]()

            guard let documents = querySnapshot?.documents else {
                self.delegateGroceryItemEvents?.groceryItemList(itemList: itemList)
            return
           }

            _ = documents.map { queryDocumentSnapshot -> Void in
                
                do {
                let data = queryDocumentSnapshot.data()
                 
                let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                var item = try JSONDecoder().decode(GroceryItem.self, from: jsonObj)
                item.id = queryDocumentSnapshot.documentID
                itemList.append(item)
                }
                catch{
                    self.delegateGroceryItemEvents?.groceryItemList(itemList: itemList)
                }
            }
        
            self.delegateGroceryItemEvents?.groceryItemList(itemList: itemList)
        }
    }
    

    func fetchRestockItems() {
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
    
    func deleteItem(item: Grocery, completion: @escaping(Bool)->()) {
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(item.id).delete() { err in
            if let err = err {
                print("Error removing item: \(err)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func deleteGroceryItem(item: GroceryItem, listId: String, completion: @escaping(Bool)->()) {
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("grocery").document(listId).collection("list").document(item.id).delete() { err in
            if let err = err {
                print("Error removing item: \(err)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
