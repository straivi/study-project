//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Properties

    var post: PostModel?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let aPost = post else { return }
        title = aPost.author

        imageView.image = UIImage(named: aPost.imageName)
        descriptionLabel.text = aPost.description
    }
}
