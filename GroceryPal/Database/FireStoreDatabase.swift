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
    private init(){}
    
    var delegateItemEvents: ItemEvents?
    
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

        firebaseDb.collection("user").document(UserDefaults.standard.string(forKey: "userId")!).collection("items").addSnapshotListener { (querySnapshot, error) in
          
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
        guard var dictionary = json as? [String : Any] else {
            return
        }
            
            let docRef = firebaseDb.collection("user").document(UserDefaults.standard.string(forKey: "userId")!).collection("items").document()
        
            dictionary["id"] = docRef.documentID

            firebaseDb.collection("user").document(UserDefaults.standard.string(forKey: "userId")!).collection("items").document(docRef.documentID).setData(dictionary)
            {
            err in
                            if(image != nil)
                            {
                                self.uploadImagePic(image: image!, docId: docRef.documentID, dispatch: dispatch)
                            }
                            else
                            {
                                dispatch.leave()
                            }

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
        
        catch{
            completed(false)
        }
    }
    
    func uploadImagePic(image: UIImage, docId: String, dispatch: DispatchGroup) {
        guard let imageData: Data = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let storageRef = Storage.storage().reference().child(UserDefaults.standard.string(forKey: "userId")!+"/"+docId+"/item.jpg")

        storageRef.putData(imageData, metadata: nil){ (metaData, error) in
            
            dispatch.leave()

            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
