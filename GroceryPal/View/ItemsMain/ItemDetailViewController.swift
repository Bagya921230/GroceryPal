//
//  ItemDetailViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/10/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown
import FirebaseStorage

protocol ItemDetailViewControllerDelegate {
    func displayCategories(list: [String])
    func displayUOM(list: [String])
    func displayError(msg: String)
    func performSuccess()
    func displayValuesInScreen()
}

class ItemDetailViewController: UIViewController, ImagePickerDelegate, ItemDetailViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var roLevel: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var uomDropDown: DropDown!
    @IBOutlet weak var roLevelUnit: UILabel!
    @IBOutlet weak var nonUnitPriceView: UIStackView!
    @IBOutlet weak var nonUnitPrice: UITextField!
    @IBOutlet weak var perVal: UITextField!
    @IBOutlet weak var nonUnitPriceViewUnit: UILabel!
    
    var imagePicker: ImagePicker!
    let itemDetailVM = ItemDetailVM()
    var selectedImage: UIImage!
    
    var selectedItem: Item?
    var isEditMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.hideKeyboardWhenTappedAround(scrollView: scrollView)
        itemDetailVM.delegate = self
        
        itemDetailVM.onLoad()
        self.handleDropDown()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
         self.imagePicker.present(from: self.view)
     }
    
    func configureUI() {
        notes.layer.borderColor = UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.0).cgColor;
        notes.layer.borderWidth = 1.0;
        notes.layer.cornerRadius = 5.0;
        
        if(isEditMode)
        {
            let onSaveBarItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(onSave))
            self.navigationItem.rightBarButtonItem  = onSaveBarItem
            
            self.navigationItem.title = "Update Item"
            
        }
        else
        {
            let onSaveBarItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSave))
            self.navigationItem.rightBarButtonItem  = onSaveBarItem
            
            self.navigationItem.title = "Add Item"
        }
    }

    
    func displayValuesInScreen()
    {
        if isEditMode == true
        {
            if let item = selectedItem {
                
                self.handlePrice(selectedUnit: item.uom)

                name.text = item.name
                
                categoryDropDown.selectedIndex = itemDetailVM.getSelectedDropDownIndex(list: categoryDropDown.optionArray, findText: item.category)
                categoryDropDown.text = item.category
                
                uomDropDown.selectedIndex = itemDetailVM.getSelectedDropDownIndex(list: uomDropDown.optionArray, findText: item.uom)
                uomDropDown.text = item.uom
                
                roLevel.text = Common.getFormattedDecimalString(value: item.roLevel)
                notes.text = item.notes
                
                if(item.uom == "unit")
                {
                    price.text = Common.getFormattedDecimalString(value: item.unitPrice)
                }
                else
                {
                    nonUnitPrice.text = Common.getFormattedDecimalString(value: item.unitPrice)
                    perVal.text = Common.getFormattedDecimalString(value: item.perValue)
                }
                
                if(item.image != "")
                {
                    let referenceImage = Storage.storage().reference().child(item.image)
                    imageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "add_item"))
                }
            }
        }
    }
    
    func handleDropDown()
    {
        uomDropDown.didSelect{(selectedText , index ,id) in
        self.roLevelUnit.text = selectedText
        self.nonUnitPriceViewUnit.text = selectedText
        self.handlePrice(selectedUnit: selectedText)
        }
    }
    
    func handlePrice(selectedUnit: String)
    {
        if(selectedUnit == "unit")
        {
            self.nonUnitPriceView.isHidden = true
            self.price.isHidden = false
        }
        else
        {
            self.nonUnitPriceView.isHidden = false
            self.price.isHidden = true
        }
    }


    @objc func onSave() {
        let name =  self.name.text!
        let category =  self.categoryDropDown.text!
        let uom =  self.uomDropDown.text!
        let notes =  self.notes.text!
        let roLevel =  self.roLevel.text!
        let price =  self.price.text!
        let nonUnitPrice =  self.nonUnitPrice.text!
        let perVal =  self.perVal.text!

        Common.showActivityIndicatory(view: self.view)
        _ = itemDetailVM.sendValues(name: name, category: category, uom: uom,notes:notes,price:price,nonUnitPrice:nonUnitPrice,perVal:perVal, roLevel:roLevel, image:selectedImage, isEditMode: isEditMode, selectedItem: selectedItem)
    }

    
    // image picker
    func didSelect(image: UIImage?) {
        if (image != nil)
        {
        self.imageView.image = image
        self.selectedImage = image
        }
    }
    
    func displayCategories(list: [String]) {
         let selectedVal = list[0]
         self.categoryDropDown.optionArray = list
         self.categoryDropDown.selectedIndex = 0
         self.categoryDropDown.text = selectedVal
    }
     
     func displayUOM(list: [String]) {
         let selectedVal = list[0]
         self.uomDropDown.optionArray = list
         self.uomDropDown.selectedIndex = 0
         
         self.uomDropDown.text = selectedVal
         self.roLevelUnit.text = selectedVal
         self.nonUnitPriceViewUnit.text = selectedVal
        
         self.handlePrice(selectedUnit: selectedVal)
     }
     
    func performSuccess() {
        Common.stopActivityIndicatory()
        navigationController?.popViewController(animated: true)
    }
       
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
    
}
