//
//  ManualViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    //MARK: - Outlets
    @IBOutlet weak var expiryTextField: UITextField!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var measurementTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    // MARK: - Actions
    @IBAction func selectExpiryDate(_ sender: Any) {
        showDatePickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showDatePickerView() {
        print("ABC,,,,")
        expiryTextField.text = "sdfafa"
//        let datePicker = ActionSheetDatePicker(title: "", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date.dateFromNow(years: -18), doneBlock: {
//            picker, value, index in
//            self.dateOfBirthTextField.text = (value as! Date).getDobFromStanded()
//            self.viewModel.dateOfBirth.accept(self.dateOfBirthTextField.text)
//            self.viewModel.dbBirthday.accept((value as! Date).getDobFromStanded(by: "yyyy-MM-dd"))
//            return
//        }, cancel: { ActionStringCancelBlock in return }, origin: view)
//        
//        
//        datePicker?.maximumDate = Date.dateFromNow(years: -18)
//        
//        if #available(iOS 12.0, *) {
//            if self.traitCollection.userInterfaceStyle == .dark {
//                // User Interface is Dark
//                datePicker?.pickerBackgroundColor = ColorName.black.color
//                datePicker?.toolbarButtonsColor = ColorName.white.color
//                
//            } else {
//                datePicker?.pickerBackgroundColor = ColorName.white.color
//                datePicker?.toolbarButtonsColor = ColorName.black.color
//                // User Interface is Light
//            }
//        } else {
//            // Fallback on earlier versions
//            datePicker?.pickerBackgroundColor = ColorName.white.color
//            datePicker?.toolbarButtonsColor = ColorName.black.color
//        }
//        datePicker?.show()
    }

}
