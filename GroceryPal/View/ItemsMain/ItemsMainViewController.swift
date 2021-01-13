//
//  ItemsEmptyViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/10/21.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class ItemsMainViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var emptyContainer: UIView!
    @IBOutlet weak var listContainerView: UIView!
    
    var itemList = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(itemList.count == 0){
           showEmptyView()
        } else {
           showListView()
        }
    }
    
    func showEmptyView() {
        emptyContainer.alpha = 1
        listContainerView.alpha = 0
    }
    
    func showListView() {
        emptyContainer.alpha = 0
        listContainerView.alpha = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemList"{
            if let vc = segue.destination as? ItemsListViewController {
                vc.itemList = itemList
            }
        }
    }
    
}
