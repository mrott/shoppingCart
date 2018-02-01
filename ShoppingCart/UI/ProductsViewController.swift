//
//  ProductsViewController.swift
//  ShoppingCart
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import UIKit
import CoreData

fileprivate struct ProductsViewControllerConstants {
    static let cartSegue = "cart"
}

class ProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var fetchedResultsController: NSFetchedResultsController<Product>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        setupFetchRequestController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCartButton()
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
        let fetchRequest = NSFetchRequest<Product>(entityName: Product.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
            fetchedResultsController = controller
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
    
    fileprivate func updateCartButton() {
        let title = String(format: "Cart - %d items", SaleManager.shared.currentSale?.saleItems?.count ?? 0)
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(cartPressed))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc fileprivate func cartPressed() {
        performSegue(withIdentifier: ProductsViewControllerConstants.cartSegue, sender: self)
    }
}

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath)
        
        if let product = fetchedResultsController?.object(at: indexPath), let productCell = cell as? ProductTableViewCell {
            productCell.configure(product: product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = fetchedResultsController?.object(at: indexPath) {
            SaleManager.shared.addProduct(product: product)
            updateCartButton()
        }
    }
}

extension ProductsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ProductsViewController {
            viewWillAppear(animated)
        }
    }
}
