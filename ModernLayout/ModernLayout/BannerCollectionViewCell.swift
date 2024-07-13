//
//  BannerCollectionViewCell.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    static let id = "BannerCollectionViewCell"
    
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
 
    private func setUI() {
        // Snapkit
        self.addSubview(titleLabel)
        self.addSubview(backgroundImage)
        
        // Constraints
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func config(title: String, imageUrl: String) {
        // title, image set
        titleLabel.text = "Title"
        // imageUrl
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
