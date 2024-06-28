//
//  DetailPosterTableViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/27/24.
//

import UIKit

class DetailHeaderCollectionView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 0
        let cellSpacing: CGFloat = 0
        let width = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: width, height: 450)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing,
                                           left: sectionSpacing,
                                           bottom: sectionSpacing,
                                           right: sectionSpacing)
        
        return layout
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.register(DetailPosterCollectionCell.self, forCellWithReuseIdentifier: DetailPosterCollectionCell.identifier)
        collectionView.backgroundColor = .bg
        collectionView.indicatorStyle = .black
    }
}
