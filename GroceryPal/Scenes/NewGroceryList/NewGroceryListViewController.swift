//
//  NewGroceryListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class NewGroceryListViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Action
    @IBAction func saveAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI();
    }
    
    func configureUI() {
        bgView.allRoundCorners(radius: 8)
        saveButton.allRoundCorners(radius: 8)
    }

}
