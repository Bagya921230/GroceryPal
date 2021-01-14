//
//  FireStoreDatabase.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/3/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class FireStoreDataBase
{

    static let shared : FireStoreDataBase = FireStoreDataBase()
    let firebaseDb = Firestore.firestore()
    let userId = UserDefaults.standard.string(forKey: "userId")!
    private init(){}
    
    var delegateItemEvents: ItemEvents?
    var delegateStockItemEvents: StockItemEvents?
    
    func addUser(dispatch:DispatchGroup, docId:String, name:String, completed: @escaping (Bool) -> Void)
    {
            dispatch.enter()

           firebaseDb.collection("user").document(docId).setData([
               "userName": name,
           ]) { err in
            
               dispatch.leave()
               if let err = err {
                    print("Error writing user: \(err)")
                    dispatch.notify(queue: .main, execute: {
                            completed(true)
                      })
               } else {
                    print("User data successfully written!")
                    dispatch.notify(queue: .main, execute: {
                            completed(true)
                      })
               }
           }
    }
    
    func fetchCategories(dispatch:DispatchGroup, completed: @escaping ([String]) -> Void)
    {
        var categoryList = [String]()
        dispatch.enter()

        firebaseDb.collection("category").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            return
          }

        _ = documents.map { queryDocumentSnapshot -> Void in
            let data = queryDocumentSnapshot.data()
            let catName = data["catName"] as? String ?? ""
            categoryList.append(catName)
        }
        
        dispatch.leave()

        dispatch.notify(queue: .main, execute: {
                completed(categoryList)
          })
        }
    }
    
    func fetchUOM(dispatch:DispatchGroup, completed: @escaping ([String]) -> Void)
       {
           var unitOfMeasurementList = [String]()
           dispatch.enter()

           firebaseDb.collection("unit of measurement").addSnapshotListener { (querySnapshot, error) in
             guard let documents = querySnapshot?.documents else {
               return
             }

           _ = documents.map { queryDocumentSnapshot -> Void in
               let data = queryDocumentSnapshot.data()
               let name = data["uom"] as? String ?? ""
               unitOfMeasurementList.append(name)
           }
           
           dispatch.leave()

           dispatch.notify(queue: .main, execute: {
                   completed(unitOfMeasurementList)
             })
           }
       }
    
    func fetchItems()
    {
        var itemList = [Item]()

        firebaseDb.collection("user").document(self.userId).collection("items").addSnapshotListener { (querySnapshot, error) in
          
            guard let documents = querySnapshot?.documents else {
            self.delegateItemEvents?.itemList(itemList: itemList)
            return
           }

            _ = documents.map { queryDocumentSnapshot -> Void in
                
                do {
                let data = queryDocumentSnapshot.data()
                 
                let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                let item = try JSONDecoder().decode(Item.self, from: jsonObj)
                itemList.append(item)
                }
                catch{
                    self.delegateItemEvents?.itemList(itemList: itemList)
                }
            }
        
            self.delegateItemEvents?.itemList(itemList: itemList)
        }
    }
    
    func addItems(item: Item, image: UIImage?, dispatch:DispatchGroup, completed: @escaping (Bool) -> Void)
    {
        dispatch.enter()
              
        do {
        let jsonData = try item.jsonData()
        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        var dictionary = json as! [String : Any]
            
            let docRef = firebaseDb.collection("user").document().collection("items").document()
            let path = self.userId+"/"+docRef.documentID+"/item.jpg"
            
            self.uploadImagePic(image: image, path: path)
            {
                result in
                
                dictionary["id"] = docRef.documentID
                dictionary["image"] = path
                
                self.firebaseDb.collection("user").document(self.userId).collection("items").document(docRef.documentID).setData(dictionary)
                    {
                    err in
                                   dispatch.leave()

                                   if let err = err {
                                       print("Error adding item: \(err)")
                                        dispatch.notify(queue: .main, execute: {
                                                             completed(false)
                                                       })
                                   } else {
                                        print("Item data successfully written!")
                                        dispatch.notify(queue: .main, execute: {
                                                                 completed(true)
                                       })
                                   }
                    }
            }
        }
        
        catch{
            completed(false)
        }
    }
    
    func uploadImagePic(image: UIImage?, path: String, completion: @escaping(Bool)->()) {
        
        if image != nil
        {
            let imageData: Data = image!.jpegData(compressionQuality: 0.1)!
            let storageRef = Storage.storage().reference().child(path)

            storageRef.putData(imageData, metadata: nil){ (metaData, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                completion(true)
            }
        }
        else
        {
            completion(true)
        }
    }
    
    func fetchStatuses(dispatch:DispatchGroup, completed: @escaping ([String]) -> Void)
    {
        var statusList = [String]()
        dispatch.enter()

        firebaseDb.collection("status").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            return
          }

        _ = documents.map { queryDocumentSnapshot -> Void in
            let data = queryDocumentSnapshot.data()
            let catName = data["statName"] as? String ?? ""
            statusList.append(catName)
        }
        
        dispatch.leave()

        dispatch.notify(queue: .main, execute: {
                completed(statusList)
          })
        }
    }
    
    //MARK: - Fetch stock items
    func fetchStockItems() {
        var stockItemList = [StockItem]()

        firebaseDb.collection("user").document(self.userId).collection("stock items").addSnapshotListener { (querySnapshot, error) in
          
            guard let documents = querySnapshot?.documents else {
                self.delegateStockItemEvents?.stockItemList(stockItemList: stockItemList)
            return
           }

            _ = documents.map { queryDocumentSnapshot -> Void in
                
                do {
                let data = queryDocumentSnapshot.data()
                 
                let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                let stockItem = try JSONDecoder().decode(StockItem.self, from: jsonObj)
                stockItemList.append(stockItem)
                }
                catch{
                    self.delegateStockItemEvents?.stockItemList(stockItemList: stockItemList)
                }
            }
        
            self.delegateStockItemEvents?.stockItemList(stockItemList: stockItemList)

        }
    }
    
    func addStockItem(item: StockItem, dispatch:DispatchGroup, completed: @escaping (Bool) -> Void) {
        dispatch.enter()
        
        do {
            let jsonData = try item.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            var dictionary = json as! [String : Any]
            
            let newDocRef = firebaseDb.collection("user").document().collection("stock items").document()
            self.firebaseDb.collection("user").document(self.userId).collection("stock items")
                .document(newDocRef.documentID)
                .setData(dictionary) { err in
                dispatch.leave()
                
                if let err = err {
                    print("Error adding item: \(err)")
                    dispatch.notify(queue: .main, execute: {
                        completed(false)
                    })
                } else {
                    print("Item data successfully written!")
                    dispatch.notify(queue: .main, execute: {
                        completed(true)
                    })
                    self.updateItemWhenStorageUpdate(item: item)
                }
            }
        } catch {
            completed(false)
        }
    }
    
    func updateItemWhenStorageUpdate (item: StockItem) {
//        dispatch.enter()
//        
//        do {
//            var dictionary = ["unitPrice": item.unitPrice, "perValue": item.perValue]
//            
//            let docRef = firebaseDb.collection("user").document().collection("stock items").whereField("name", isEqualTo: item.name).
//            self.firebaseDb.collection("user").document(self.userId).collection("stock items")
//                .document(docRef.documentID)
//                .setData(dictionary, merge: true) { err in
//                dispatch.leave()
//                
//                if let err = err {
//                    print("Error adding item: \(err)")
//                    dispatch.notify(queue: .main, execute: {
//                        completed(false)
//                    })
//                } else {
//                    print("Item data successfully written!")
//                    dispatch.notify(queue: .main, execute: {
//                        completed(true)
//                    })
//                    self.updateItemWhenStorageUpdate()
//                }
//            }
//        } catch {
//            completed(false)
//        }
    }
}
