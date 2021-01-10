//
//  ItemListTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/1/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {

    //MARK:- Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.bgView.layer.cornerRadius = 8
        self.bgView.layer.masksToBounds = true
    }
    
    func setUp(name: String, image: UIImage, category: String) {
        nameLabel.text = name
        categoryLabel.text = category
        itemImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
