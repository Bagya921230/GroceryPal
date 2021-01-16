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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        requestAuthForLocalNotifications()
        
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
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
    }
    
    func requestAuthForLocalNotifications() {
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert,.sound]){ (granted, error) in
            if error != nil {
            
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if let customData = notification.request.content.userInfo["id"] as? String {
            print("ID",customData)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                NotificationCenter.default.post(name: Notification.Name("ADD_NOTIFICATION"), object: nil, userInfo: notification.request.content.userInfo)
                
            }
        }
        completionHandler(UNNotificationPresentationOptions.init(arrayLiteral: [.alert, .badge]))
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

