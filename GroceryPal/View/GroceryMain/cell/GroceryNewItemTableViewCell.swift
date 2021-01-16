//
//  GroceryNewItemTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/10/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit
import FirebaseUI

class GroceryNewItemTableViewCell: UITableViewCell {

    //MARK:- Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.bgView.layer.cornerRadius = 8
        self.bgView.layer.masksToBounds = true
    }
    
    func setUp(item: GroceryItem) {
        nameLabel.text = item.name
        if (item.uom == "unit") {
            qtyLabel.text = String(format: "%.0f",item.quantity)
        } else {
            qtyLabel.text = String(format: "%.2f%@",item.quantity,item.uom)
        }
        totalLabel.text = String(format: "%@%.2f","LKR ",item.total)
        let referenceImage = Storage.storage().reference().child(item.image)
        itemImageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "placeholder"))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
