//
//  ItemListVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/14/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation

class ItemListVM {

    var delegate: ItemsListViewControllerDelegate?
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
    
    func deleteItem(docId: String)
    {
        fireStoreQueries!.deleteItems(docId: docId)
        {
            status in
                           if(!status)
                           {
                               self.delegate?.displayError(msg: "Cannot delete the item")
                           }
        }
    }
}
