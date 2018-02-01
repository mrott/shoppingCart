//
//  CurrenciesViewController.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit

protocol CurrenciesViewControllerDelegate: class {
    func currenciesViewControllerCompleted(currency: Currency)
}

class CurrenciesViewController: UIViewController {

    weak var delegate: CurrenciesViewControllerDelegate?
    var currencies: [Currency] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        
        weak var _self = self
        NetworkRequest.getCurrencies { (completed, currencies) in
            if let _self = _self {
                _self.currencies = currencies
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension CurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath)
        
        if let currencyCell = cell as? CurrencyTableViewCell {
            currencyCell.configure(currency: currencies[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        if let delegate = delegate {
            delegate.currenciesViewControllerCompleted(currency: currency)
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
