//
//  UIViewExtension.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(_ corners:UIRectCorner,_ cormerMask:CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *){
            self.clipsToBounds = false
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cormerMask
        }else{
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = rectShape
        }
    }
    
    func allRoundCorners(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func addBorderColor() {
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor.gray.cgColor
        roundCorners([.topLeft,.bottomLeft,.topRight, .bottomRight], [.layerMinXMaxYCorner,.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 10)
    }
    
}
