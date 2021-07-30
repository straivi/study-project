//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {

    // MARK: - Private properties

    private let output: FeedViewOutput

    private let feedView = FeedView()

    // MARK: - Construction

    init(output: FeedViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.navigationController = navigationController
        setupLayout()
        let action = { [weak self] in
            guard let self = self else { return }
            self.output.showPost(post: postsList.randomElement())
        }
        feedView.configure(buttonAction: action)
    }

    // MARK: - Private function

    private func setupLayout() {
        view.backgroundColor = .green

        view.addSubview(feedView)
        feedView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
