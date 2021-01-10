//
//  StorageItemTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class StorageItemTableViewCell: UITableViewCell {

    //MARK:- Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var expiredImageView: UIImageView!
    @IBOutlet weak var stockImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.bgView.layer.cornerRadius = 8
        self.bgView.layer.masksToBounds = true
        self.stockImageView.isHidden = true
        self.expiredImageView.isHidden = true
    }
    
    func setUp(name: String,image: UIImage, quantity: String, date: String, level: String, expired: Bool, outOfStock: Bool) {
        nameLabel.text = name
        quantityLabel.text = quantity
        dateLabel.text = date
        levelLabel.text = level
        itemImageView.image = image
        if (outOfStock) {
            stockImageView.isHidden = false
            expiredImageView.isHidden = true
        }
        if (expired) {
            expiredImageView.isHidden = false
            stockImageView.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
