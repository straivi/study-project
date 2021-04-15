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
        let feedVC = configureNavController(with: FeedViewController.self,
                                            image: AppImage.houseFillSymbol,
                                            title: "Feed")
        let profileVC = configureNavController(with: ProfileViewController.self,
                                               image: AppImage.personFillSymbol,
                                               title: "Profile")
        viewControllers = [feedVC, profileVC]
    }
    
    private func configureNavController(with viewController: UIViewController.Type, image: UIImage?, title: String?) -> UINavigationController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier:
                                                String(describing: viewController.self))
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        nav.title = title
        return nav
    }
}
