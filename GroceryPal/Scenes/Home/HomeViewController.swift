//
//  HomeViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var storageView: UIView!
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var groceryListView: UIView!
    @IBOutlet weak var restockNeededView: UIView!
    @IBOutlet weak var statisticsView: UIView!
    
    // MARK: - Actions
    @IBAction func clickStorage(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func clickGrocery(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func clickItems(_ sender: Any) {
        performSegue(withIdentifier: "segueItemMain", sender: nil)
    }
    
    @IBAction func clickRestock(_ sender: Any) {
        performSegue(withIdentifier: "segueRestockMain", sender: nil)
    }
    
    @IBAction func clickStatistics(_ sender: Any) {
        performSegue(withIdentifier: "segueStatistics", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configureUI() {
        storageView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        itemsView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        groceryListView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        restockNeededView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
        statisticsView.roundCorners([.topRight, .bottomRight], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 20)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
