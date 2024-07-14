//
//  NormalCollectionViewCell.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit

import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {
    
    static let id = "NormalCollectionViewCell"
    
    let image = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        
        return image
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight:  .bold)
        label.numberOfLines = 2
        
        return label
    }()
    
    let reviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight:  .medium)
        
        return label
    }()
    
    let descLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight:  .regular)
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(image)
        self.addSubview(titleLabel)
        self.addSubview(reviewLabel)
        self.addSubview(descLabel)
        
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    public func configure(title: String, review: String, desc: String, imageUrl: String) {
        image.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        reviewLabel.text = review
        descLabel.text = desc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
