//
//  ProductTableViewCell.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let identifier = "ProductTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var unitTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(product: Product) {
        nameLabel.text = product.name
        unitTypeLabel.text = product.unitType
        priceLabel.text = String(product.price) + " USD"
    }
    
}
