//
//  CustomProfileHeaderView.swift
//  StudyProject
//
//  Created by  Matvey on 25.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class CustomProfileHeaderView: UIView {

    // MARK: - Properties

    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.Subview.textSecondary
        label.text = "I did it at 6 a.m..."
        label.textAlignment = .left
        return label
    }()

    let statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show status", for: .normal)
        button.layer.cornerRadius = 14
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.Subview.buttonPrimary
        return button
    }()

    let statusEditTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.placeholder = "Enter status..."
        textField.borderStyle = .none
        return textField
    }()

    // MARK: - Private properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Sad shrimp"
        label.textAlignment = .left
        return label
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: AppImage.profilePlaceholder)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50
        return imageView
    }()

    private let fullscreenBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame.size = UIScreen.main.bounds.size
        return view
    }()

    private let fullscreenAvatarImageView: UIImageView = {
        let imageView = UIImageView(image: AppImage.profilePlaceholder)
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()

    private let closeFullscreenButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppImage.multiplyCircleSymbol, for: .normal)
        button.tintColor = UIColor.Subview.viewBackground
        button.alpha = 0
        return button
    }()

    // MARK: - Сonstruction

    init() {
        super.init(frame: .zero)
        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc private func openFullscreenAvatar() {
        let avatarFrameCopy = self.convert(avatarImageView.frame, to: fullscreenBackgroundView)
        fullscreenAvatarImageView.frame = avatarFrameCopy
        let keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)
        keyWindow?.addSubview(fullscreenBackgroundView)
        keyWindow?.bringSubviewToFront(fullscreenBackgroundView)
        avatarImageView.isHidden = true

        UIView.animateKeyframes(withDuration: 0.8, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.fullscreenBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.fullscreenAvatarImageView.center = self.fullscreenBackgroundView.center
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.fullscreenAvatarImageView.frame = CGRect(x: 0,
                                                              y: self.fullscreenBackgroundView.center.y - self.fullscreenBackgroundView.bounds.width / 2,
                                                              width: self.fullscreenBackgroundView.bounds.width,
                                                              height: self.fullscreenBackgroundView.bounds.width)
                self.fullscreenAvatarImageView.layer.cornerRadius = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                self.closeFullscreenButton.alpha = 1
            }
        }
    }

    @objc private func closeFullscreenAvatar() {
        let avatarFrameCopy = self.convert(avatarImageView.frame, to: fullscreenBackgroundView)
        UIView.animateKeyframes(withDuration: 0.8, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self.closeFullscreenButton.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.5) {
                self.fullscreenBackgroundView.backgroundColor = .clear
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.25) {
                self.fullscreenAvatarImageView.frame.size = avatarFrameCopy.size
                self.fullscreenAvatarImageView.center = self.fullscreenBackgroundView.center
                self.fullscreenAvatarImageView.layer.cornerRadius = 50
            }
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.25) {
                self.fullscreenAvatarImageView.frame = avatarFrameCopy
            }
        } completion: { _ in
            self.fullscreenBackgroundView.removeFromSuperview()
            self.avatarImageView.isHidden = false
        }
    }

    // MARK: - Private functions

    private func setupActions() {
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFullscreenAvatar)))
        closeFullscreenButton.addTarget(self, action: #selector(closeFullscreenAvatar), for: .touchUpInside)
    }
    
    private func setupLayout() {
        backgroundColor = .clear

        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.equalTo(100)
            make.width.equalTo(avatarImageView.snp.height)
        }

        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(32)
            make.trailing.lessThanOrEqualToSuperview()
        }

        addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(32)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.lessThanOrEqualToSuperview()
        }

        addSubview(statusEditTextField)
        statusEditTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(statusLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }

        addSubview(statusButton)
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(statusEditTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }

        fullscreenBackgroundView.addSubview(fullscreenAvatarImageView)
        fullscreenBackgroundView.addSubview(closeFullscreenButton)

        closeFullscreenButton.snp.makeConstraints { make in
            make.top.equalTo(fullscreenBackgroundView.safeAreaLayoutGuide.snp.top).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
}
