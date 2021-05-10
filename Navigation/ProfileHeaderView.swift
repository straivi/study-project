//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by  Matvey on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusEditTextField: PaddingTextField!
    
    private let fullscreenBackgroundView = UIView()
    private let fullscreenAvatarImageView = UIImageView(image: AppImage.profilePlaceholder)
    @objc private let closeFullscreenButton = UIButton(type: .custom)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubViews()
        setupActions()
    }
    
    private func setupSubViews() {
        self.backgroundColor = .clear
        
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = 50
        
        statusButton.layer.cornerRadius = 14
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowOpacity = 0.7
        
        statusEditTextField.layer.borderWidth = 1
        statusEditTextField.layer.borderColor = UIColor.black.cgColor
        statusEditTextField.layer.cornerRadius = 12
        
        let screensize = UIScreen.main.bounds.size
        fullscreenBackgroundView.frame.size = screensize
        fullscreenBackgroundView.backgroundColor = .clear
        
        fullscreenAvatarImageView.layer.borderWidth = 3
        fullscreenAvatarImageView.layer.borderColor = UIColor.white.cgColor
        fullscreenAvatarImageView.layer.cornerRadius = 50
        fullscreenAvatarImageView.clipsToBounds = true
        fullscreenBackgroundView.addSubview(fullscreenAvatarImageView)
        
        fullscreenBackgroundView.addSubview(closeFullscreenButton)
        closeFullscreenButton.setImage(AppImage.multiplyCircleSymbol, for: .normal)
        closeFullscreenButton.tintColor = UIColor.Subview.background
        closeFullscreenButton.alpha = 0
        closeFullscreenButton.translatesAutoresizingMaskIntoConstraints = false
        let closeButtonConstraints = [
            closeFullscreenButton.heightAnchor.constraint(equalToConstant: 50),
            closeFullscreenButton.widthAnchor.constraint(equalToConstant: 50),
            closeFullscreenButton.topAnchor.constraint(equalTo: fullscreenBackgroundView.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeFullscreenButton.trailingAnchor.constraint(equalTo: fullscreenBackgroundView.trailingAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(closeButtonConstraints)
    }
    
    private func setupActions() {
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFullscreenAvatar)))
        closeFullscreenButton.addTarget(self, action: #selector(closeFullscreenAvatar), for: .touchUpInside)
    }
    
    @objc private func openFullscreenAvatar() {
        let avatarFrameCopy = self.convert(avatarImageView.frame, to: fullscreenBackgroundView)
        fullscreenAvatarImageView.frame = avatarFrameCopy
        print(closeFullscreenButton.constraints)
        print(fullscreenBackgroundView.constraints)
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
}

extension UIView {
    class func loadFromNib() -> Self? {
        let bundle = Bundle(for: Self.self)
        let nib = bundle.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)
        let view = nib?.first as? Self
        return view
    }
}
