//
//  UpdateStorageViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/30/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit
import Foundation

class UpdateStorageViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        if let selectedItem = selectedItem {
            if (selectedItem.uom == "unit") {
                unitView.alpha = 1
                nonUnitView.alpha = 0
                addedQty.text = String(format: "%.0f", selectedItem.initialQty)
                roLevel.text = String(format: "%.0f", selectedItem.roLevel)
                remainQty.text = String(format: "%.0f", selectedItem.quantity)
            } else {
                unitView.alpha = 0
                nonUnitView.alpha = 1
                addedQty.text = Common.getFormattedDecimalString(value: selectedItem.initialQty)
                roLevel.text = Common.getFormattedDecimalString(value: selectedItem.roLevel)
                remainQty.text = Common.getFormattedDecimalString(value: selectedItem.quantity)
            }
            name.text = selectedItem.name
            category.text = selectedItem.category
            addedOn.text = selectedItem.addedDate
            expDate.text = selectedItem.expDate
            uom.text = selectedItem.uom
            price.text = Common.getFormattedDecimalString(value: selectedItem.unitPrice)
            notes.text = selectedItem.notes
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc
    func onUpdate() {
        
    }

}
