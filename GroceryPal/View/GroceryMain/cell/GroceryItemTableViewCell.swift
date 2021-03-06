//
//  GroceryItemTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit
import FirebaseUI

class GroceryItemTableViewCell: UITableViewCell {

    //MARK:- Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.bgView.layer.cornerRadius = 8
        self.bgView.layer.masksToBounds = true
    }
    
    func setUp(item: StockItem) {
        nameLabel.text = item.name
        if (item.uom == "unit") {
            qtyLabel.text = String(format: "%.0f",item.quantity)
        } else {
            qtyLabel.text = String(format: "%.2f%@",item.quantity,item.uom)
        }
        let referenceImage = Storage.storage().reference().child(item.image)
        itemImageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "placeholder"))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
