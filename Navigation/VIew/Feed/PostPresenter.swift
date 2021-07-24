//
//  PostPresenter.swift
//  StudyProject
//
//  Created by  Matvey on 24.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostPresenter: FeedViewOutput {
    var navigationController: UINavigationController?

    func showPost(post: PostModel?) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let postVC = sb.instantiateViewController(withIdentifier: String( describing: PostViewController.self)) as? PostViewController else { return }
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }

}
