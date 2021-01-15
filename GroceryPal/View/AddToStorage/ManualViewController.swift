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
    func displayError(msg: String)
    func addSuccess()
}

class ManualViewController: UIViewController, ManualViewControllerDelegate, ItemEvents, ScanViewControllerDelegate {

    //MARK: - Outlets
    @IBOutlet weak var expiryTextField: UITextField!
    @IBOutlet weak var itemNameDropdown: DropDown!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var measurementTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var unitPriceTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let manualVM = ManualVM()
    var itemList = [Item]()
    var selectedItem: Item?
    let fireStoreItemQueries = FireStoreItemQueries()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            configureUI()
        } else {
            // Fallback on earlier versions
        }
        fireStoreItemQueries.delegateItemEvents = self
        manualVM.delegate = self
        manualVM.onLoad(fireStoreQueries: fireStoreItemQueries)
        handleItemDropDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        let onSaveBarItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneAction))
        self.navigationItem.rightBarButtonItem  = onSaveBarItem
    }
    
    func configureUI() {
        expiryTextField.setRightIcon(icon: UIImage(systemName: "calendar")!)
        priceTextField.setRightLabel(text: "LKR")
        itemNameDropdown.setLeftIcon(icon: UIImage(systemName: "magnifyingglass")!)
        expiryTextField.setInputViewDatePicker(target: self, selector: #selector(tapDatePickerDone))
    }
    
    @objc func tapDatePickerDone() {
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
    
    @objc
    func onDoneAction() {
        let name =  self.itemNameDropdown.text!
        let category =  self.selectedItem?.category
        let uom =  self.selectedItem?.uom
        let notes = self.selectedItem?.notes
        let image = self.selectedItem?.image
        let unitPrice =  self.unitPriceTextField.text!
        let nonUnitPrice =  self.priceTextField.text!
        let perVal =  self.measurementTextField.text!
        let roLevel =  self.selectedItem?.roLevel
        let quantity = self.quantityTextField.text!
        let expDate = self.expiryTextField.text!

        Common.showActivityIndicatory(view: self.view)
        _ = manualVM.sendValues(name: name, category: category!, uom: uom!, notes:notes!,unitPrice: unitPrice, nonUnitPrice:nonUnitPrice, perVal:perVal, roLevel:roLevel!, quantity: quantity, expDate: expDate, image: image!)
    }
    
    func didScan(msg: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let pickerDateformatter = DateFormatter()
        pickerDateformatter.dateStyle = .medium
        self.expiryTextField.text = pickerDateformatter.string(from: dateFormatter.date(from: msg)!)
    }
    
    func displayItems(list: [String]) {
        self.itemNameDropdown.optionArray = list
    }
    
    func handleItemDropDown()
    {
        itemNameDropdown.didSelect{(selectedText , index ,id) in
            self.selectedItem = self.itemList[index]
            
            self.categoryLabel.text = self.itemList[index].category
            if self.itemList[index].uom == "unit" {
                self.unitPriceTextField.text = String(format: "%.2f", self.itemList[index].unitPrice)
                self.unitPriceTextField.isHidden = false
                self.priceTextField.isHidden = true
                self.measurementTextField.isHidden = true
                self.quantityTextField.setRightLabel(text: "")
            } else {
                self.measurementTextField.setRightLabel(text: self.itemList[index].uom)
                self.quantityTextField.setRightLabel(text: self.itemList[index].uom)
                self.measurementTextField.text = String(format: "%.2f", self.itemList[index].perValue)
                self.priceTextField.text = String(format: "%.2f", self.itemList[index].unitPrice)
                self.unitPriceTextField.isHidden = true
                self.priceTextField.isHidden = false
                self.measurementTextField.isHidden = false
            }
        }
    }
    
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func addSuccess() {
        Common.stopActivityIndicatory()
        navigationController?.popViewController(animated: true)
    }
    
    func itemList(itemList: [Item]) {
        self.itemList = itemList
        var dropdownList = [String]()
        for item in itemList {
            dropdownList.append(item.name)
        }
        displayItems(list: dropdownList)
    }

}
