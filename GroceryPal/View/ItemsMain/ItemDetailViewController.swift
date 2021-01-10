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

protocol ItemDetailViewControllerDelegate {
    func displayCategories(list: [String])
    func displayUOM(list: [String])
    func displayError(msg: String)
    func addSuccess()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailVM.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.hideKeyboardWhenTappedAround(scrollView: scrollView)
        itemDetailVM.onLoad()
        self.handleDropDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addTextViewBorder()
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
    
    func addTextViewBorder()
    {
        notes.layer.borderColor = UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.0).cgColor;
        notes.layer.borderWidth = 1.0;
        notes.layer.cornerRadius = 5.0;
    }

    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.imagePicker.present(from: self.view)
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        let name =  self.name.text!
        let category =  self.categoryDropDown.text!
        let uom =  self.uomDropDown.text!
        let notes =  self.notes.text!
        let roLevel =  self.roLevel.text!
        let price =  self.price.text!
        let nonUnitPrice =  self.nonUnitPrice.text!
        let perVal =  self.perVal.text!

        Common.showActivityIndicatory(view: self.view)
        _ = itemDetailVM.sendValues(name: name, category: category, uom: uom,notes:notes,price:price,nonUnitPrice:nonUnitPrice,perVal:perVal, roLevel:roLevel)
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // image picker
    func didSelect(image: UIImage?) {
        if (image != nil)
        {
        self.imageView.image = image
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
     
    func addSuccess() {
//           let storyboard = UIStoryboard(name: "Home", bundle: nil)
//           let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
//           self.navigationController?.pushViewController(homeViewController, animated: true)
    }
       
    func displayError(msg: String) {
           Common.stopActivityIndicatory()
           Common.showAlert(msg: msg, viewController: self)
    }
}
