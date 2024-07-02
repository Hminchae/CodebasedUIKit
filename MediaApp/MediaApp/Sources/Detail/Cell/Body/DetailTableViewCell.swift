//
//  DetailCollectionTableViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

final class DetailTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-10)
            make.height.equalTo(160)
        }
    }
    
    override func configureView() {
        titleLabel.shadowOffset = .init(width: 2, height: 2)
    }
}
