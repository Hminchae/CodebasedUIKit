//
//  MainTopTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainTopTableViewCell: BaseTableViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionViewLayout())
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let frame = UIScreen.main.bounds
        layout.itemSize = CGSize(width: (frame.width - 45) / 2, height: 80)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}