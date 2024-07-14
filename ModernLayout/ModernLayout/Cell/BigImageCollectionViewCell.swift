//
//  BigImageCollectionViewCell.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit

import Kingfisher

class BigImageCollectionViewCell: UICollectionViewCell {
    
    static let id = "BigImageCollectionViewCell"
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
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
        addSubview(image)
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(reviewLabel)
        stackView.addArrangedSubview(descLabel)
        
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(14)
            make.trailing.bottom.equalToSuperview().offset(-14)
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
