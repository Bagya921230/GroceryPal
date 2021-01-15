//
//  LandingViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signup.createRoundedButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.tintColor = UIColor.themeColor();
    }
}
