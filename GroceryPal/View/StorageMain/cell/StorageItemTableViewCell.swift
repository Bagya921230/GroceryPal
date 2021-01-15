//
//  StorageItemTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseUI

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
    
    func setUp(item: StockItem) {
        nameLabel.text = item.name
        quantityLabel.text = String(format: "%.2f",item.quantity)
        dateLabel.text = item.expDate
        levelLabel.text = String(format: "%.2f",item.roLevel)
        let referenceImage = Storage.storage().reference().child(item.image)
        itemImageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "placeholder"))
        if (item.status == "restock") {
            stockImageView.isHidden = false
            expiredImageView.isHidden = true
        }
        if (item.status == "expired" ) {
            expiredImageView.isHidden = false
            stockImageView.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
