//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by  Matvey on 06.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    let photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageVeiw = UIImageView()
        imageVeiw.image = AppImage.arrowForwardSymbol
        imageVeiw.tintColor = .black
        return imageVeiw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(photosLabel)
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        let photosLabelConstraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ]
        NSLayoutConstraint.activate(photosLabelConstraints)
        
        contentView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        let arrowImageVeiwConstraints = [
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(arrowImageVeiwConstraints)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "1"))
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "2"))
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "3"))
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "4"))
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewContraints = [
            stackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 65)
        ]
        NSLayoutConstraint.activate(stackViewContraints)
    }
    
    private func createСonfiguredImageVeiw(imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
