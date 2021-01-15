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
    
    func addUser(docId:String, name:String, completed: @escaping (Bool) -> Void)
    {
           firebaseDb.collection("user").document(docId).setData([
               "userName": name,
           ]) { err in
            
               if let err = err {
                    print("Error writing user: \(err)")
                    completed(false)

               } else {
                    print("User data successfully written!")
                    completed(true)
               }
           }
    }
    
    func fetchCategories(completed: @escaping ([String]) -> Void)
    {
        var categoryList = [String]()

        firebaseDb.collection("category").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            return
          }

        _ = documents.map { queryDocumentSnapshot -> Void in
            let data = queryDocumentSnapshot.data()
            let catName = data["catName"] as? String ?? ""
            categoryList.append(catName)
        }
        
            completed(categoryList)
        }
    }
    
    func fetchUOM(completed: @escaping ([String]) -> Void)
       {
           var unitOfMeasurementList = [String]()

           firebaseDb.collection("unit of measurement").addSnapshotListener { (querySnapshot, error) in
             guard let documents = querySnapshot?.documents else {
               return
             }

           _ = documents.map { queryDocumentSnapshot -> Void in
               let data = queryDocumentSnapshot.data()
               let name = data["uom"] as? String ?? ""
               unitOfMeasurementList.append(name)
           }
           
            completed(unitOfMeasurementList)
           }
       }
    
    func fetchStatus(completed: @escaping ([String]) -> Void)
    {
        var statusList = [String]()

        firebaseDb.collection("status").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            return
          }

        _ = documents.map { queryDocumentSnapshot -> Void in
            let data = queryDocumentSnapshot.data()
            let name = data["statName"] as? String ?? ""
            statusList.append(name)
        }
        
         completed(statusList)
        }
    }
}
