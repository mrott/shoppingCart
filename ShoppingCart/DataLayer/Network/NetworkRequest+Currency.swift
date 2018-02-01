//
//  CurrencyNetwork.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import Foundation

extension NetworkRequest {
    
    static func getCurrencies(completion:@escaping (_ completed: Bool, _ currencies: [Currency]) -> Void) {
        let url = URL(string: NetworkConfiguration.currencyUrl)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if let json = jsonSerialized, let quotes = json["quotes"] as? [String: Float] {
                        var currencies: [Currency] = []
                        for quote in quotes {
                            let currency = Currency()
                            currency.name = quote.key
                            currency.value = quote.value
                            currencies.append(currency)
                        }
                        completion(true, currencies)
                    }
                    else {
                        completion(false, [])
                    }
                }  catch let _ as NSError {
                    completion(false, [])
                }
            } else if error != nil {
                completion(false, [])
            }
        }
        
        task.resume()

    }
    
}
