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
        photosLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
        }
        
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalTo(photosLabel.snp.centerY)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "1"))
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "2"))
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "3"))
        stackView.addArrangedSubview(createСonfiguredImageVeiw(imageName: "4"))
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(65)
        }
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
