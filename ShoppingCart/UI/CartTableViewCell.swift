//
//  CartTableViewCell.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit

protocol CartTableViewCellDelegate: class {
    func cartTableViewCellPlus(saleItem: SaleItem)
    func cartTableViewCellMinus(saleItem: SaleItem)
    func cartTableViewCellRemove(saleItem: SaleItem)
}

class CartTableViewCell: UITableViewCell {

    static let identifier = "CartTableViewCell"
    
    var saleItem: SaleItem?
    weak var delegate: CartTableViewCellDelegate?
    
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
    
    func configure(saleItem: SaleItem, currency: Currency?, delegate: CartTableViewCellDelegate?) {
        self.saleItem = saleItem
        self.delegate = delegate
        
        nameLabel.text = saleItem.product?.name
        unitTypeLabel.text = saleItem.product?.unitType
        var price = (saleItem.product?.price ?? 0) * Float(saleItem.quantity)
        if let currency = currency {
            price = price * currency.value
            priceLabel.text = String(format: "%.2f", price) + " " + currency.name
        }
        else {
            priceLabel.text = String(format: "%.2f", price) + " USD"
        }
        quantityLabel.text = "Quantity: " + String(saleItem.quantity )
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        if let delegate = delegate, let saleItem = saleItem {
            delegate.cartTableViewCellPlus(saleItem: saleItem)
        }
    }
    
    @IBAction func minusPressed(_ sender: Any) {
        if let delegate = delegate, let saleItem = saleItem {
            delegate.cartTableViewCellMinus(saleItem: saleItem)
        }
    }
    
    @IBAction func removePressed(_ sender: Any) {
        if let delegate = delegate, let saleItem = saleItem {
            delegate.cartTableViewCellRemove(saleItem: saleItem)
        }
    }
}
