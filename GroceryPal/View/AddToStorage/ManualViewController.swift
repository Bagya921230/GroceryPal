//
//  ManualViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit
import iOSDropDown

protocol ManualViewControllerDelegate {
    func displayItems(list: [String])
    func displayError(msg: String)
    func addSuccess()
}

class ManualViewController: UIViewController, ManualViewControllerDelegate {
        
    //MARK: - Outlets
    @IBOutlet weak var expiryTextField: UITextField!
    @IBOutlet weak var itemNameDropdown: DropDown!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var measurementTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        displayItems(list: ["All","Expired","Restock","Active","A","B","C","D","E"])
    }
    
    func configureUI() {
        expiryTextField.setRightIcon(icon: UIImage(systemName: "calendar")!)
        quantityTextField.setRightLabel(text: "kg")
        measurementTextField.setRightLabel(text: "kg")
        priceTextField.setRightLabel(text: "LKR")
        itemNameDropdown.setLeftIcon(icon: UIImage(systemName: "magnifyingglass")!)
        expiryTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func tapDone() {
         if let datePicker = self.expiryTextField.inputView as? UIDatePicker {
             let dateformatter = DateFormatter()
             dateformatter.dateStyle = .medium
             self.expiryTextField.text = dateformatter.string(from: datePicker.date)
         }
         self.expiryTextField.resignFirstResponder()
     }

    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    
    func displayItems(list: [String]) {
        let selectedVal = list[0]
        self.itemNameDropdown.optionArray = list
        self.itemNameDropdown.selectedIndex = 0
        self.itemNameDropdown.text = selectedVal
    }
    
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func addSuccess() {
        
    }

}
