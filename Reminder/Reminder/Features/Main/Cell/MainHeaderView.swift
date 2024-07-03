//
//  MainTopTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainHeaderView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionViewLayout())
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let frame = UIScreen.main.bounds
        layout.itemSize = CGSize(width: (frame.width - 60) / 2, height: 80)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        collectionView.register(MainHeaderCollectionViewCell.self, forCellWithReuseIdentifier: MainHeaderCollectionViewCell.identifier)
        collectionView.backgroundColor = .bg
    }
}
