//
//  DetailSeveralCollectionViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

import Kingfisher

class DetailCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        posterImageView.backgroundColor = .black.withAlphaComponent(0.7)
        posterImageView.clipsToBounds = true
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10
        posterImageView.contentMode = .scaleAspectFill
    }
}
