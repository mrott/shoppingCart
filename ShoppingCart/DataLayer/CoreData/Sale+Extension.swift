//
//  Sale+Extension.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import Foundation
import CoreData

extension Sale {
    
    static let entityName = "Sale"
    
    static func newObject() -> Sale? {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                         into: CoreDataManager.shared.managedObjectContext)
        return object as? Sale
    }
    
    func saleItem(with product: Product) -> SaleItem? {
        guard let saleItems = saleItems else {
            return nil
        }
        for saleItem in saleItems {
            if let saleItem = saleItem as? SaleItem, saleItem.product == product {
                return saleItem
            }
        }
        return nil
    }
}
