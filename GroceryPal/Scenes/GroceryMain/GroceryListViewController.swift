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

    @IBAction func addItemAction(_ sender: Any) {
        performSegue(withIdentifier: "segueAddItemToGrocery", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
            return 3
        case newListTableView:
            return 3
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "groceryTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroceryItemTableViewCell else {
            fatalError("The dequed cell is not an instance of GroceryItemTableViewCell")
        }
        switch tableView {
        case autoTableView:
            cell.setUp(name: "Coconut Oil", image: UIImage(named: "temp")!, quantity: "-")
            return cell
        case newListTableView:
            cell.setUp(name: "Coconut Oil", image: UIImage(named: "temp")!, quantity: "5")
            return cell
        default:
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

}
