//
//  ItemListTableViewCell.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/1/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseUI

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
    
    func setUp(item: Item) {
        nameLabel.text = item.name
        categoryLabel.text = item.category
        
        let referenceImage = Storage.storage().reference().child(item.image)
        SDImageCache.shared.removeImage(forKey: referenceImage.fullPath)
        itemImageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "placeholder"))
    }
    
    func setUp(restockItem: StockItem) {
        nameLabel.text = restockItem.name
        categoryLabel.text = restockItem.category
        
        let referenceImage = Storage.storage().reference().child(restockItem.image)
        SDImageCache.shared.removeImage(forKey: referenceImage.fullPath)
        itemImageView.sd_setImage(with: referenceImage,placeholderImage: UIImage(named: "placeholder"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
