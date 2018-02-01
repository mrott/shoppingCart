//
//  CartViewController.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit
import CoreData

fileprivate struct CartViewControllerConstants {
    static let currenciesSegue = "currencies"
}

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var fetchedResultsController: NSFetchedResultsController<SaleItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        setupFetchRequestController()
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

    fileprivate func setupFetchRequestController() {
        let context = CoreDataManager.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<SaleItem>(entityName: SaleItem.entityName)
        if let currentSale = SaleManager.shared.currentSale {
            let predicate = NSPredicate(format: "sale = %@", currentSale)
            fetchRequest.predicate = predicate
        }
        else {
            return
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "product.name", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
            fetchedResultsController = controller
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
    
    @IBAction func currenciesPressed(_ sender: Any) {
        performSegue(withIdentifier: CartViewControllerConstants.currenciesSegue, sender: self)
    }
    
    @IBAction func finishSalePressed(_ sender: Any) {
        
    }
    
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath)
        
        if let saleItem = fetchedResultsController?.object(at: indexPath), let cartCell = cell as? CartTableViewCell {
            cartCell.configure(saleItem: saleItem)
        }
        
        return cell
    }
    
}

