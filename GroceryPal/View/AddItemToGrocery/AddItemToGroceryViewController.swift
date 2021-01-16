//
//  AddItemToGroceryViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit
import iOSDropDown

protocol AddItemToGroceryViewControllerDelegate {
    func displayError(msg: String)
    func addSuccess()
}

class AddItemToGroceryViewController: UIViewController, AddItemToGroceryViewControllerDelegate, ItemEvents {

    @IBOutlet weak var itemNameDropdown: DropDown!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var delegateGrocery: GroceryListViewControllerDelegate?
    let addItemVM = AddItemToGroceryVM()
    var selectedItem: Item?
    var listId: String?
    let fireStoreItemQueries = FireStoreItemQueries()
    var itemList = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addItemVM.delegate = self
        handleItemDropDown()
        fireStoreItemQueries.delegateItemEvents = self
        addItemVM.onLoad(fireStoreQueries: fireStoreItemQueries)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
        style: .plain,
        target: self,
        action: #selector(onDoneAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#008891ff")

    }
    
    func displayItems(list: [String]) {
        self.itemNameDropdown.optionArray = list
    }
    
    @objc
    func onDoneAction() {
        onSave()
    }
    
    func onSave() {
        let name =  self.itemNameDropdown.text!
        let category =  self.selectedItem?.category ?? ""
        let uom =  self.selectedItem?.uom ?? ""
        let image = self.selectedItem?.image ?? ""
        let perVal = self.selectedItem?.perValue ?? 0
        let unitPrice =  self.selectedItem?.unitPrice ?? 0
        let quantity = self.quantityTextField.text!
        let listId = self.listId ?? ""

        Common.showActivityIndicatory(view: self.view)
        _ = addItemVM.sendValues(name: name, category: category, uom: uom, unitPrice: unitPrice, id: "", quantity: quantity, image: image, listId: listId, perVal: perVal)
    }
    
    func handleItemDropDown()
    {
        itemNameDropdown.didSelect{(selectedText , index ,id) in
            self.selectedItem = self.itemList[index]
            self.categoryLabel.text = self.itemList[index].category
        }
    }

    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
    func addSuccess() {
        Common.stopActivityIndicatory()
        delegateGrocery?.addNewItem()
        self.navigationController?.popViewController(animated: true)
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
