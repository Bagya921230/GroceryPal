//
//  UpdateStorageViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/30/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit
import Foundation
import FirebaseUI

protocol UpdateStorageViewControllerDelegate {
    func displayError(msg: String)
    func addSuccess()
}

class UpdateStorageViewController: UIViewController ,UpdateStorageViewControllerDelegate{

    var selectedItem: StockItem?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var addedQty: UILabel!
    @IBOutlet weak var addedOn: UILabel!
    @IBOutlet weak var expDate: UILabel!
    @IBOutlet weak var roLevel: UILabel!
    @IBOutlet weak var uom: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var remainQty: UILabel!
    @IBOutlet weak var unitView: UIView!
    @IBOutlet weak var nonUnitView: UIView!
    @IBOutlet weak var remainNonunitQty: UILabel!
    @IBOutlet weak var approxQty: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var itemImageView: UIImageView!
    
    let updateStorageVM = UpdateStorageVM()
    let fireStoreItemQueries = FireStoreItemQueries()
    
    var initNonUnitVal : Double = 0.0
    var currentVal : Int = 0
    var uomVal : String = ""
    var newNonUnitVal : Double = 0.0
    var newUnitVal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        updateStorageVM.delegate = self
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
            
        remainNonunitQty.text = "\(currentValue)%"
        let approxVal = calculateValueByPercentage(initValue: self.initNonUnitVal, percentageVal: Double(currentValue))
        approxQty.text = "Approximately \(Common.getFormattedDecimalString(value: approxVal))\(uomVal)"
        self.newNonUnitVal = approxVal
    }
    
    @IBAction func increaseQtyAction(_ sender: Any) {
        if (newUnitVal < currentVal) {
            newUnitVal += 1
            remainQty.text = "\(newUnitVal)"
        }
        enableButtons()
    }
    @IBAction func reduceQtyAction(_ sender: Any) {
        if (newUnitVal > 0) {
            newUnitVal -= 1
            remainQty.text = "\(newUnitVal)"
        }
        enableButtons()
    }
    
    func enableButtons() {
        if (newUnitVal > 0 && newUnitVal < currentVal) {
            //enable both
            minusButton.isEnabled = true
            plusButton.isEnabled = true
        } else if (newUnitVal > 0) {
            //enable minus
            minusButton.isEnabled = true
            plusButton.isEnabled = false
        } else if (newUnitVal < currentVal) {
            //enable plus
            minusButton.isEnabled = false
            plusButton.isEnabled = true
        } else {
            //disable both
            minusButton.isEnabled = false
            plusButton.isEnabled = false
        }
    }
    
    func setUpUI() {
        if let selectedItem = selectedItem {
            if (selectedItem.uom == "unit") {
                unitView.alpha = 1
                nonUnitView.alpha = 0
                addedQty.text = String(format: "%.0f", selectedItem.initialQty)
                roLevel.text = String(format: "%.0f", selectedItem.roLevel)
                remainQty.text = String(format: "%.0f", selectedItem.quantity)
                self.newUnitVal = Int(selectedItem.quantity)
                self.currentVal = Int(selectedItem.quantity)
                enableButtons()
            } else {
                unitView.alpha = 0
                nonUnitView.alpha = 1
                addedQty.text = Common.getFormattedDecimalString(value: selectedItem.initialQty)
                roLevel.text = Common.getFormattedDecimalString(value: selectedItem.roLevel)
                remainQty.text = Common.getFormattedDecimalString(value: selectedItem.quantity)
                self.initNonUnitVal = selectedItem.quantity
                self.uomVal = selectedItem.uom
                let value = Common.getFormattedDecimalDouble(value: calculatePercentage(initValue: selectedItem.initialQty, currentVal: selectedItem.quantity)) 
                slider.setValue(Float(value), animated: true)
                remainNonunitQty.text = "\(value)%"
                
            }
            let referenceImage = Storage.storage().reference().child(selectedItem.image)
            itemImageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "placeholder"))
            name.text = selectedItem.name
            category.text = selectedItem.category
            addedOn.text = selectedItem.addedDate
            expDate.text = selectedItem.expDate
            uom.text = selectedItem.uom
            price.text = Common.getFormattedDecimalString(value: selectedItem.unitPrice)
            notes.text = selectedItem.notes
        }
    }
    
    public func calculatePercentage(initValue:Double,currentVal:Double)->Double{
        let val = currentVal / initValue
        return val * 100.0
    }
    
    public func calculateValueByPercentage(initValue: Double, percentageVal: Double) -> Double {
        let val = initValue * percentageVal
        return val / 100.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        let addBarItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(onUpdate))
        self.navigationItem.rightBarButtonItem  = addBarItem
    }
    
    @objc
    func onUpdate() {
        var quantity : Double = 0.0
        if let stockItem = selectedItem {
            if stockItem.uom == "unit" {
                quantity = Double(newUnitVal)
            } else {
                quantity = self.newNonUnitVal
            }

            Common.showActivityIndicatory(view: self.view)
            _ = updateStorageVM.sendValues(item: stockItem, newQtyVal: quantity)
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

}
