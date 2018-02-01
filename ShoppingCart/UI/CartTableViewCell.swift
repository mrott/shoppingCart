//
//  CartTableViewCell.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    static let identifier = "CartTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var unitTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(saleItem: SaleItem) {
        nameLabel.text = saleItem.product?.name
        unitTypeLabel.text = saleItem.product?.unitType
        let price = (saleItem.product?.price ?? 0) * Float(saleItem.quantity)
        priceLabel.text = String(format: "%.2f", price) + "$"
        quantityLabel.text = "Quantity: " + String(saleItem.quantity )
    }
    

}
