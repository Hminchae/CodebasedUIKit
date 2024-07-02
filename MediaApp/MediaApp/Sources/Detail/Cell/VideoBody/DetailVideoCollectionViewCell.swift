//
//  DetailVideoCollectionViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 7/2/24.
//

import UIKit


final class DetailVideoCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = UIImageView()

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
        posterImageView.layer.cornerRadius = 8
        posterImageView.contentMode = .scaleAspectFill
    }
}
