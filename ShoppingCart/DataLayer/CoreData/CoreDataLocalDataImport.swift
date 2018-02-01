//
//  CoreDataLocalDataImport.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import Foundation

class CoreDataLocalDataImport {
    
    func importFile(plistFilename: String) {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: plistFilename) != nil {
            return
        }
        
        if let url = Bundle.main.url(forResource: plistFilename, withExtension: "plist") {
            guard url.pathExtension == "plist", let data = try? Data(contentsOf: url) else {
                return
            }
            
            do {
                guard let plistProducts = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] else {
                    return
                }
                
                for plistProduct in plistProducts {
                    if let product = Product.newObject() {
                        product.name = plistProduct["name"] as? String
                        product.price = plistProduct["price"] as? Float ?? 0
                        product.unitType = plistProduct["unitType"] as? String
                    }
                }
                
                CoreDataManager.shared.saveContext()
                
                userDefaults.set(true, forKey: plistFilename)
            }
            catch {
                
            }
        }
    }
    
}
