//
//  ListCollectionViewCell.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit

import Kingfisher

class ListCollectionViewCell: UICollectionViewCell {
    
    static let id = "ListCollectionViewCell"
    
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
        
        return label
    }()
    
    let releaseDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight:  .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        
        image.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(image.snp.width)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(image.snp.centerY)
            make.leading.equalTo(image.snp.trailing).offset(8)
        }
    }
    
    public func configure(title: String, 
                          releaseDate: String,
                          imageUrl: String
    ) {
        image.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
