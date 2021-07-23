//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by  Matvey on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    let likesLabel = UILabel()
    let viewsLabel = UILabel()
    let postImageView = UIImageView()

    private let imageProcessor = ImageProcessor()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textAlignment = .left
        
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textAlignment = .right
    }
    
    private func setupLayout() {
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        authorLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        
        contentView.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(likesLabel)
        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(viewsLabel)
        viewsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(post: Post) {
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        if let image = UIImage(named: post.imageName) {
            let invertFilter = ColorFilter.colorInvert
            imageProcessor.processImage(sourceImage: image, filter: invertFilter) { [weak self] (imageWithFilter) in
                self?.postImageView.image = imageWithFilter
            }
        }
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
}
