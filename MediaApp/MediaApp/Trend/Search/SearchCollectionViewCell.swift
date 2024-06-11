//
//  SearchCollectionViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/11/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.addSubview(mainImageView)
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
