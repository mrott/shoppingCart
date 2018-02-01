//
//  SaleManager.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import Foundation
import CoreData

class SaleManager {
    
    static let shared = SaleManager()
    
    private init() {
        
    }
    
    var currentSale: Sale?
    
    fileprivate func createSale() {
        currentSale = Sale.newObject()
        currentSale?.createdDate = Date()
    }
    
    func addProduct(product: Product) {
        if currentSale == nil {
            createSale()
        }
        guard let currentSale = currentSale else {
            return
        }
        
        if let existingSaleItem = currentSale.saleItem(with: product) {
            existingSaleItem.quantity = existingSaleItem.quantity + 1
        }
        else {
            let saleItem = SaleItem.newObject()
            saleItem?.sale = currentSale
            saleItem?.quantity = 1
            saleItem?.product = product
        }
        CoreDataManager.shared.saveContext()
    }
    
    func set(saleItem: SaleItem, quantity: Int) {
        
    }
    
    fileprivate func updateSaleFinalValue() {
        
    }
    
    func closeSale() {
        currentSale = nil
    }
}
