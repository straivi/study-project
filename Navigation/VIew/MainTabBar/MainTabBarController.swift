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
        let feedVC = configureFeedNavigationController()
        let profileVC = configureStoryboardNavController(with: ProfileViewController.self,
                                               image: AppImage.personFillSymbol,
                                               title: "Profile")
        viewControllers = [feedVC, profileVC]
    }
    
    private func configureStoryboardNavController(with viewController: UIViewController.Type, image: UIImage?, title: String?) -> UINavigationController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier:
                                                String(describing: viewController.self))
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        nav.title = title
        return nav
    }

    private func configureFeedNavigationController() -> UINavigationController {
        let postPresenter = PostPresenter()
        let feedVC = FeedViewController(output: postPresenter)
        let nav = UINavigationController(rootViewController: feedVC)
        nav.tabBarItem.image = AppImage.houseFillSymbol
        nav.title = "Feed"
        return nav

    }
}
