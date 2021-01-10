//
//  common.swift
//  GroceryPal

//
//  Created by Aparna Prasad on 1/4/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class Common
{
    static let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    static func showActivityIndicatory(view: UIView) {
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.color = UIColor.themeColor()
        view.addSubview(myActivityIndicator)
        myActivityIndicator.startAnimating()
    }
    
    static func stopActivityIndicatory() {
        myActivityIndicator.stopAnimating()
    }
    
    static func showAlert(msg: String, viewController: UIViewController) {
         let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
         viewController.present(alert, animated: true, completion: nil)
    }
}
