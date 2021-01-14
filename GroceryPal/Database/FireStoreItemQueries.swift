//
//  FireStoreItemQueries.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class FireStoreItemQueries
{
    
    let userId = UserDefaults.standard.string(forKey: "userId")!
    var delegateItemEvents: ItemEvents?
    
    func fetchItems()
    {

        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("items").addSnapshotListener { (querySnapshot, error) in
          
            var itemList = [Item]()

            guard let documents = querySnapshot?.documents else {
            self.delegateItemEvents?.itemList(itemList: itemList)
            return
           }

            _ = documents.map { queryDocumentSnapshot -> Void in
                
                do {
                let data = queryDocumentSnapshot.data()
                 
                let jsonObj = try JSONSerialization.data(withJSONObject: data, options: [])
                var item = try JSONDecoder().decode(Item.self, from: jsonObj)
                item.id = queryDocumentSnapshot.documentID
                itemList.append(item)
                }
                catch{
                    self.delegateItemEvents?.itemList(itemList: itemList)
                }
            }
        
            self.delegateItemEvents?.itemList(itemList: itemList)
        }
    }

    func addItems(item: Item, image: UIImage?, completed: @escaping (Bool) -> Void)
    {
        
        let docRef = FireStoreDataBase.shared.firebaseDb.collection("user").document().collection("items").document()

        self.uploadImagePic(image: image, docId: docRef.documentID){
            path in
            
            do
            {
                let jsonData = try item.jsonData()
                let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                var dictionary = json as! [String : Any]
                dictionary["id"] = docRef.documentID
                dictionary["image"] = path
                
                FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("items").document(docRef.documentID).setData(dictionary)
                {
                        err in

                                       if let err = err {
                                           print("Error adding item: \(err)")
                                                                                                    completed(false)

                                       } else {
                                            print("Item data successfully written!")
                                                                                                            completed(true)

                                       }
                }
                
            }
            
            catch{
                completed(false)
            }
        }
    }

    func uploadImagePic(image: UIImage?, docId: String, completion: @escaping(String)->())
    {
        
        var path: String = ""
        if image != nil
        {
            path = self.userId+"/"+docId+"/item.jpg"

            let imageData: Data = image!.jpegData(compressionQuality: 0.1)!
            let storageRef = Storage.storage().reference().child(path)

            storageRef.putData(imageData, metadata: nil){ (metaData, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                completion(path)
            }
        }
        else
        {
             completion(path)
        }
    }

    func deleteItems(docId: String, completion: @escaping(Bool)->())
    {
        FireStoreDataBase.shared.firebaseDb.collection("user").document(self.userId).collection("items").document(docId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                completion(false)
            } else {
                print("Document successfully removed!")
                completion(true)
            }
        }
    }

}
