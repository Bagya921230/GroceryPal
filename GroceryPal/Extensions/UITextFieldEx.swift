//
//  UITextFieldEx.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/13/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setRightIcon(icon: UIImage) {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(hex: "#979797ff")
        imageView.image = icon
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        let padding: CGFloat = 6
        let rightView = UIView(frame: CGRect(
            x: 0, y: 0,
            width: imageView.frame.width + padding,
            height: imageView.frame.height))
        rightView.addSubview(imageView)
        self.rightView = rightView;
        self.rightViewMode = .always
    }
    
    func setLeftIcon(icon: UIImage) {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(hex: "#979797ff")
        imageView.image = icon
        imageView.frame = CGRect(x: 6, y: 0, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        let leftView = UIView(frame: CGRect(
            x: 0, y: 0,
            width: imageView.frame.width + 6,
            height: imageView.frame.height))
        leftView.addSubview(imageView)
        self.leftView = leftView;
        self.leftViewMode = .always
    }
    
    func setRightLabel(text: String) {
        let label = UILabel()
        label.textColor = UIColor(hex: "#979797ff")
        label.text = text
        label.font = label.font.withSize(12)
        let width = label.intrinsicContentSize.width
        label.frame = CGRect(x: 0, y: 0, width: width, height: 24)
        let padding: CGFloat = 6
        let rightView = UIView(frame: CGRect(
            x: 0, y: 0, // keep this as 0, 0
            width: label.frame.width + padding, // add the padding
            height: label.frame.height))
        rightView.addSubview(label)
        self.rightView = rightView;
        self.rightViewMode = .always
    }
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        datePicker.date = currentDate
        
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

