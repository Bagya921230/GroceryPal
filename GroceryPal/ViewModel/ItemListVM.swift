//
//  ItemListVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

class ItemListVM {

    var fireStoreQueries: FireStoreItemQueries?

    func onLoad(fireStoreQueries: FireStoreItemQueries)
    {
        self.fireStoreQueries = fireStoreQueries
        fireStoreQueries.fetchItems()
    }
    
    func filterList(searchText: String, itemList: [Item]) -> [Item]
    {
        return itemList.filter {
             item in
            return item.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func deleteItem(item: Item, completion: @escaping(Bool)->())
    {
        fireStoreQueries!.deleteItems(item: item)
        {
            status in
            completion(status)
        }
    }
}
