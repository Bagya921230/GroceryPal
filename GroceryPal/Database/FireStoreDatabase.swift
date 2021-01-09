//
//  FireStoreDatabase.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/3/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FireStoreDataBase
{

    static let shared : FireStoreDataBase = FireStoreDataBase()
    let firebaseDb = Firestore.firestore()
    private init(){}
    
    func addUser(dispatch:DispatchGroup, docId:String, name:String, completed: @escaping (Bool) -> Void)
    {
            dispatch.enter()

           firebaseDb.collection("user").document(docId).setData([
               "userName": name,
           ]) { err in
            
               dispatch.leave()
               if let err = err {
                    print("Error writing document: \(err)")
                    dispatch.notify(queue: .main, execute: {
                            completed(true)
                      })
               } else {
                   print("Document successfully written!")
                    dispatch.notify(queue: .main, execute: {
                            completed(true)
                      })
               }
           }
    }
    
    func fetchCategories(dispatch:DispatchGroup, completed: @escaping ([Category]) -> Void)
    {
        var categoryList = [Category]()
        dispatch.enter()

        firebaseDb.collection("category").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            return
          }

        _ = documents.map { queryDocumentSnapshot -> Void in
            let data = queryDocumentSnapshot.data()
            let catName = data["catName"] as? String ?? ""
            categoryList.append(Category(id: queryDocumentSnapshot.documentID,name: catName))
        }
        
        dispatch.leave()

        dispatch.notify(queue: .main, execute: {
                completed(categoryList)
          })
        }
    }
    
    func fetchUOM(dispatch:DispatchGroup, completed: @escaping ([UnitOfMeasurement]) -> Void)
       {
           var unitOfMeasurementList = [UnitOfMeasurement]()
           dispatch.enter()

           firebaseDb.collection("unit of measurement").addSnapshotListener { (querySnapshot, error) in
             guard let documents = querySnapshot?.documents else {
               return
             }

           _ = documents.map { queryDocumentSnapshot -> Void in
               let data = queryDocumentSnapshot.data()
               let name = data["uom"] as? String ?? ""
               unitOfMeasurementList.append(UnitOfMeasurement(id: queryDocumentSnapshot.documentID,name: name))
           }
           
           dispatch.leave()

           dispatch.notify(queue: .main, execute: {
                   completed(unitOfMeasurementList)
             })
           }
       }
}
