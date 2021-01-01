//
//  NotificationTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/31/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var subMsgLabel: UILabel!
    @IBOutlet weak var expiredImageView: UIImageView!
    @IBOutlet weak var stockImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Setup
    func setUp(name: String, qty: String, msg: String, subMsg: String, expired: Bool, outOfStock: Bool) {
           nameLabel.text = name
           qtyLabel.text = qty
           msgLabel.text = msg
           subMsgLabel.text = subMsg
           if (outOfStock) {
               stockImageView.isHidden = false
               expiredImageView.isHidden = true
           }
           if (expired) {
               expiredImageView.isHidden = false
               stockImageView.isHidden = true
           }
       }


}
