//
//  DetailPosterTableViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/27/24.
//

import UIKit

class DetailPosterTableViewCell: BaseTableViewCell {
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 0
        let cellSpacing: CGFloat = 0
//        let width = UIScreen.main.bounds.width
//        
//        layout.itemSize = CGSize(width: width, height: 300)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing,
                                           left: sectionSpacing,
                                           bottom: sectionSpacing,
                                           right: sectionSpacing)
        
        return layout
    }
    
    override func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(350)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
        }
    }
    
    override func configureView() {
        
    }
}
