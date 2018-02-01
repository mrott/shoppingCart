//
//  SaleItem.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import Foundation
import CoreData

extension SaleItem {
    
    static let entityName = "SaleItem"
    
    static func newObject() -> SaleItem? {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                         into: CoreDataManager.shared.managedObjectContext)
        return object as? SaleItem
    }
    
}
