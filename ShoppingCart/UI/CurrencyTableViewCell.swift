//
//  CurrencyTableViewCell.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    static let identifier = "CurrencyTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(currency: Currency) {
        nameLabel.text = currency.name
        valueLabel.text = String(format: "%.2f", currency.value)
    }

}
