//
//  FeedViewOutputProtocol.swift
//  StudyProject
//
//  Created by  Matvey on 24.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewOutput: AnyObject {

    var navigationController: UINavigationController? { get set }

    func showPost(post: PostModel?)
}
