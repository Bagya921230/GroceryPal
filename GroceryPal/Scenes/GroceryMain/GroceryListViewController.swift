//
//  GroceryListViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/9/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController {

    @IBOutlet weak var autoTableView: UITableView!
    @IBOutlet weak var newListTableView: UITableView!
    @IBOutlet var autoTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var newTableViewHeightConstraint: NSLayoutConstraint!


    @IBAction func addItemAction(_ sender: Any) {
        performSegue(withIdentifier: "segueAddItemToGrocery", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
    // Dynamically resize the table to fit the number of cells
    // Scrolling is turned off on the table in InterfaceBuilder
        autoTableView.frame.size = autoTableView.contentSize
        autoTableViewHeightConstraint.constant = autoTableView.frame.height
        newListTableView.frame.size = newListTableView.contentSize
        newTableViewHeightConstraint.constant = newListTableView.frame.height
    }
    
    func configureUI() {
        autoTableView.dataSource = self
        autoTableView.delegate = self
        autoTableView.allowsSelection = true
        autoTableView.separatorStyle = .none
        newListTableView.dataSource = self
        newListTableView.delegate = self
        newListTableView.allowsSelection = true
        newListTableView.separatorStyle = .none
    }

}
extension GroceryListViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case autoTableView:
            return 2
        case newListTableView:
            return 5
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case autoTableView:
            let cellIdentifier = "groceryTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryItemTableViewCell else {
                fatalError("The dequed cell is not an instance of GroceryItemTableViewCell")
            }
            cell.setUp(name: "Coconut Oil", image: UIImage(named: "temp")!, quantity: "-")
            return cell
        case newListTableView:
            let cellIdentifier = "groceryNewTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryNewItemTableViewCell else {
                fatalError("The dequed cell is not an instance of GroceryNewItemTableViewCell")
            }
            cell.setUp(name: "Coconut Oil", image: UIImage(named: "temp")!, quantity: "5")
            return cell
        default:
            let cellIdentifier = "groceryTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryItemTableViewCell else {
                fatalError("The dequed cell is not an instance of GroceryItemTableViewCell")
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

}
