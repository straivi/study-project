//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
            #if DEBUG_VERSION
            let phrase = "Application moved form inactive to active: \(#function)"
            print(phrase)
            #endif
        }
        
        func applicationWillResignActive(_ application: UIApplication) {
            #if DEBUG_VERSION
            let phrase = "Application moved form active to inactive: \(#function)"
            print(phrase)
            #endif
        }
        
        func applicationWillEnterForeground(_ application: UIApplication) {
            #if DEBUG_VERSION
            let phrase = "Application moved form background to inactive: \(#function)"
            print(phrase)
            #endif
        }
        
        func applicationDidEnterBackground(_ application: UIApplication) {
            #if DEBUG_VERSION
            let phrase = "Application moved form inactive to background: \(#function)"
            print(phrase)
            #endif
        }
        
        func applicationWillTerminate(_ application: UIApplication) {
            #if DEBUG_VERSION
            let phrase = "Application moved form background to suspended: \(#function)"
            print(phrase)
            #endif
        }
}

