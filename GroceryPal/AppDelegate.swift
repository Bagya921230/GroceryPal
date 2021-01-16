//
//  AppDelegate.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if(loggedIn)
        {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "homeTabBar")
        }
        else
        {
            let storyboard = UIStoryboard(name: "Landing", bundle: nil)
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "landingNavigation")
        }
        window?.makeKeyAndVisible()
        return true
    }  
}

