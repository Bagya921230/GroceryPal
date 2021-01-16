//
//  SignInViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate {
    func displayError(msg: String)
    func signInSuccess()
}

class SignInViewController: UIViewController,SignInViewControllerDelegate {

    //outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let signInVM = SignInVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        signIn.createRoundedButton()
        signInVM.delegate = self
        self.hideKeyboardWhenTappedAround(scrollView: scrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func onSignIn(_ sender: Any) {
        let email =  self.email.text!
        let pw =  self.password.text!
        
        Common.showActivityIndicatory(view: self.view)
        _ = signInVM.sendValues(email: email, pw: pw)
    }
    
    func signInSuccess() {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
//        self.navigationController?.pushViewController(homeViewController, animated: true)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "homeTabBar")
        (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    func displayError(msg: String) {
        Common.stopActivityIndicatory()
        Common.showAlert(msg: msg, viewController: self)
    }
}
