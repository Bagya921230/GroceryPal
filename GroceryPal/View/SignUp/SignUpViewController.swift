//
//  SignUpViewController.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate {
    func displayError(msg: String)
    func signUpSuccess()
}

class SignUpViewController: UIViewController, SignUpVMDelegate, SignUpViewControllerDelegate {

    //outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cpassword: UITextField!
    
    let signUpVM = SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.createRoundedButton()
        signUpVM.delegate = self
        self.hideKeyboardWhenTappedAround(scrollView: scrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func onSignUp(_ sender: Any) {
                
        let name = self.name.text!
        let email =  self.email.text!
        let pw =  self.password.text!
        let cpw =  self.cpassword.text!
        
        Common.showActivityIndicatory(view: self.view)
        _ = signUpVM.sendValues(name: name, email: email, pw: pw , cpw:cpw)
    }
    

    func signUpSuccess() {
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
