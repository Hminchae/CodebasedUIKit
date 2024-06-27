//
//  DetailPosterCollectionCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/27/24.
//

import UIKit

class DetailPosterCollectionCell: BaseCollectionViewCell {
    
    let posterHeaderImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(posterHeaderImageView)
    }
    
    override func configureLayout() {
        posterHeaderImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        posterHeaderImageView.backgroundColor = .black.withAlphaComponent(0.7)
        posterHeaderImageView.contentMode = .scaleAspectFill
    }
}

