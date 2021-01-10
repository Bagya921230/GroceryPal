//
//  SignInVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/4/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import Firebase

class SignInVM {

    var delegate: SignInViewControllerDelegate?

    func sendValues(email: String, pw: String) -> Bool
    {
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the email.")
        }
            
        else if pw.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the password.")
        }
        
        else
        {
            signInUser(email: email, pw: pw, completion: { _ in })
            return true
        }
        
        return false
    }

    
    func signInUser(email: String, pw: String, completion: @escaping(Bool)->())
    {
        Auth.auth().signIn(withEmail: email, password: pw, completion: { (authResult, error) in

            if authResult != nil {
                    UserDefaults.standard.set(true, forKey: "loggedIn")
                    UserDefaults.standard.set(authResult!.user.uid, forKey: "userId")
                    self.delegate?.signInSuccess()
                    completion(true)
            }
            else{
                 self.delegate?.displayError(msg: error!.localizedDescription)
                 completion(false)
            }
        })
    }
}
