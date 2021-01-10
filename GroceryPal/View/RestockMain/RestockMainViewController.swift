//
//  RestockMainViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class RestockMainViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var emptyContainer: UIView!
    @IBOutlet weak var listContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //showEmptyView()
        showListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func showEmptyView() {
        emptyContainer.alpha = 1
        listContainerView.alpha = 0
    }
    
    func showListView() {
        emptyContainer.alpha = 0
        listContainerView.alpha = 1
    }

}
