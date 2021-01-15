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
    static let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)

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
    
    static func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    static func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    static func getFormattedDecimalDouble(value: Double) -> Double
    {
        return (value * 100).rounded() / 100
    }
    
    static func getFormattedDecimalString(value: Double) -> String
    {
        return String(format: "%.02f", value)
    }

}
