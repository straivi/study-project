//
//  LoginViewController.swift
//  Navigation
//
//  Created by  Matvey on 25.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Private properties

    private let loginChecker: LoginCheckerProtocol

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delaysContentTouches = false
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.logo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Email or phone"
        textField.backgroundColor = UIColor.Subview.viewBackground
        textField.tintColor = UIColor.AppColor.accentColor
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Password"
        textField.backgroundColor = UIColor.Subview.viewBackground
        textField.tintColor = UIColor.AppColor.accentColor
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var textFieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.setBackgroundImage(AppImage.imageBlueBackground, for: .normal)
        let transparentImage = AppImage.imageBlueBackground?.alpha(0.8)
        button.setBackgroundImage(transparentImage, for: .selected)
        button.setBackgroundImage(transparentImage, for: .highlighted)
        button.setBackgroundImage(transparentImage, for: .disabled)
        return button
    }()

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotification()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupViews()
    }

    // MARK: - Construction

    init(loginChecker: LoginCheckerProtocol) {
        self.loginChecker = loginChecker
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeKeyboardNotification()
    }
}

// MARK: - Keyboard show/hide

extension LoginViewController {
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let freeSpaceHeight = view.bounds.height - loginButton.convert(loginButton.bounds, to: view).maxY - 8
        if !(freeSpaceHeight > kbFrameSize?.height ?? 0) {
            scrollView.contentOffset = CGPoint(x: 0, y: (kbFrameSize?.height ?? 0) - freeSpaceHeight)
        }
    }
    
    @objc private func keyboardHide() {
        scrollView.contentOffset = .zero
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Setup Layout

private extension LoginViewController {
    private func setupViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(containerViewConstraints)
        
        containerView.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        let logoImageConstraints = [
            logoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(logoImageConstraints)
        
        containerView.addSubview(textFieldsStack)
        textFieldsStack.translatesAutoresizingMaskIntoConstraints = false
        let textFieldContainerConstraints = [
            textFieldsStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            textFieldsStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textFieldsStack.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(textFieldContainerConstraints)
        
        textFieldsStack.addArrangedSubview(loginTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        
        containerView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let loginButttonConstarints = [
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(loginButttonConstarints)
    }
}

// MARK: - Actions

extension LoginViewController {
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(startLoginProcess), for: .touchUpInside)
    }

    @objc private func startLoginProcess() {
        let login = loginTextField.text
        let password = passwordTextField.text

        guard let aLogin = login,
              let aPassword = password else { return }

		if loginChecker.loginCheck(aLogin) == .success, loginChecker.passwordCheck(aPassword) == .success {
            dismiss(animated: true)
        }
    }
}

// MARK: - UIImage extension

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: value)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
