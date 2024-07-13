//
//  ViewController.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSource()
        setSnapShot()
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        })
    }
    
    private func setSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapShot.appendSections([Section(id: "Banner")]) // snapShot에 똑같은 Section을 또 넣을 수는 없다. id로 구별
        
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: "https://www.hellot.net/data/photos/20230937/art_16945858572183_8fc3f5.jpg")),
            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: "https://www.hellot.net/data/photos/20230937/art_16945858572183_8fc3f5.jpg")),
            Item.banner(HomeItem(title: "BHC 치킨", imageUrl: "https://www.hellot.net/data/photos/20230937/art_16945858572183_8fc3f5.jpg"))
        ]
        snapShot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        
        dataSource?.apply(snapShot)
    }
    
    private func createLayout () -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
          
            return self?.createBannerSection()
        })
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹의 전체영역에 할당하도록 함
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}


// 컬렉션뷰 cell UI - 등록
// 레이아웃 구현 - 3가지
// datasource -> cellProvider
// snapshot -> datasource.apply(snapshot)


// 섹션 > 그룹 > 아이템
