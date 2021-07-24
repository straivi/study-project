//
//  FeedView.swift
//  StudyProject
//
//  Created by  Matvey on 23.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class FeedView: UIView {

    // MARK: - Private properties

    private var onTap: (() -> Void)?

    private let firstButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("First post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemOrange
        return button
    }()

    private let secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Second post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemPurple
        return button
    }()

    // MARK: - Construction

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function

    func configure(buttonAction: (() -> Void)?) {
        onTap = buttonAction
        setupActions()
    }

    // MARK: - Private functions

    private func setupLayout() {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually

        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-20)
        }

        stack.addArrangedSubview(firstButton)
        stack.addArrangedSubview(secondButton)
    }

    private func setupActions() {
        firstButton.addTarget(self, action: #selector(onTapAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(onTapAction), for: .touchUpInside)
    }

    // MARK: - Action

    @objc func onTapAction() {
        onTap?()
    }
}


