//
//  SignUpVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/4/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation
import Firebase


protocol SignUpVMDelegate {
}

class SignUpVM {

    var delegate: SignUpViewControllerDelegate?

    func sendValues(name: String, email: String, pw: String, cpw: String) -> Bool
    {
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the name.")
        }
        
        else if email.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the email.")
        }
        
        else if !validEmail(email: email) {
            delegate?.displayError(msg: "Email address is not valid.")
        }
            
        else if pw.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please enter the password.")
        }
        
        else if cpw.trimmingCharacters(in: .whitespaces).isEmpty{
            delegate?.displayError(msg: "Please confirm the password.")
        }
        
        else if pw != cpw {
            delegate?.displayError(msg: "Passwords mismatch.")
        }
        
        else
        {
            createUser(email: email, pw: pw, name: name, completion: { _ in })
            return true
        }
        
        return false
    }
    
    func validEmail(email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser(email: String, pw: String, name: String, completion: @escaping(Bool)->())
    {
        Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
            if authResult != nil {
                self.addToFireStore(name: name, uid: (authResult?.user.uid)!)
                completion(true)
            }
           else {
                self.delegate?.displayError(msg: error!.localizedDescription)
                completion(false)
           }
        }
    }
    
    func addToFireStore(name:String, uid: String)
    {
        FireStoreDataBase.shared.addUser(docId: uid, name: name){status in
                   if(status)
                   {
                            UserDefaults.standard.set(true, forKey: "loggedIn")
                            UserDefaults.standard.set(uid, forKey: "userId")
                            self.delegate?.signUpSuccess()
                   }
        }
    }
}
