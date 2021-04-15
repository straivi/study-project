//
//  ProfileViewController.swift
//  Navigation
//
//  Created by  Matvey on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var tableView = UITableView(frame: .zero)
    private var profileHeaderView = ProfileHeaderView.loadFromNib()
    private lazy var statusText = profileHeaderView?.statusLabel.text ?? ""
    private var fullScreenView = UIView()
    private var fullScreenAvatarView = UIImageView(image: AppImage.profilePlaceholder)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupActions()
    }
    
    private func setupSubViews() {
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableVeiwConstrints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableVeiwConstrints)
    }
    
    private func setupActions() {
        profileHeaderView?.statusButton.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)
        profileHeaderView?.statusEditTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc private func statusButtonTapped(_ sender: UIButton) {
        profileHeaderView?.statusLabel.text = statusText
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return postsList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.section == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self)) as? PhotosTableViewCell {
            return cell
            
        } else if indexPath.section == 1,
                  let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self)) as? PostTableViewCell {
            cell.configure(post: postsList[indexPath.row])
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0,
              let profileHeaderView = profileHeaderView else { return nil }
        let view = UIView()
        view.addSubview(profileHeaderView)
        view.backgroundColor = .systemGray6
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        let headerConstraints = [
            profileHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(headerConstraints)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
