//
//  NewGroceryListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

protocol NewGroceryListViewControllerDelegate {
    func displayError(msg: String)
    func addSuccess(grocery: Grocery)
}

class NewGroceryListViewController: UIViewController, NewGroceryListViewControllerDelegate{

    //MARK: - Outlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Action
    @IBAction func saveAction(_ sender: Any) {
        onSave()
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var delegate: GroceryListViewControllerDelegate?
    let newListVM = NewGroceryListVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        newListVM.delegate = self
    }
    
    func configureUI() {
        bgView.allRoundCorners(radius: 8)
        saveButton.allRoundCorners(radius: 8)
    }
    
    func onSave() {
        let name =  self.nameTextField.text!

        Common.showActivityIndicatory(view: self.view)
        _ = newListVM.sendValues(listName: name)
    }

    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func addSuccess(grocery: Grocery) {
        Common.stopActivityIndicatory()
        delegate?.getCreatedList(grocery: grocery)
        self.dismiss(animated: true, completion: nil)
    }
}
