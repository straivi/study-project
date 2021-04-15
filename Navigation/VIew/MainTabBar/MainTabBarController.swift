//
//  MainTabBarController.swift
//  StudyProject
//
//  Created by  Matvey on 15.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let feedVC = sb.instantiateViewController(withIdentifier: String(describing: FeedViewController.self))
        feedVC.tabBarItem.image = AppImage.houseFillSymbol
        feedVC.tabBarItem.title = "Feed"
        
        let profileVC = sb.instantiateViewController(withIdentifier: String(describing: ProfileViewController.self))
        profileVC.tabBarItem.image = AppImage.personFillSymbol
        profileVC.tabBarItem.title = "Profile"
        
        viewControllers = [feedVC, profileVC]
    }
}
