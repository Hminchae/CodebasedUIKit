//
//  ViewController.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import UIKit

//class ViewController: UIViewController {
//    
//    let mockimage = "https://www.hellot.net/data/photos/20230937/art_16945858572183_8fc3f5.jpg"
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
//    
//    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setUI()
//        
//        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
//        collectionView.register(NormalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCaroselCollectionViewCell.id)
//        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
//        collectionView.setCollectionViewLayout(createLayout(), animated: true)
//        collectionView.setCollectionViewLayout(createLayout(), animated: true)
//        setDataSource()
//        setSnapShot()
//    }
//    
//    private func setUI() {
//        self.view.addSubview(collectionView)
//        collectionView.backgroundColor = .white
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    
//    private func setDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            
//            switch itemIdentifier {
//            case .banner(let item):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else {
//                    return UICollectionViewCell()
//                }
//                
//                cell.config(title: item.title, imageUrl: item.imageUrl)
//                
//                return cell
//            case .normalCarousel(let item):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCaroselCollectionViewCell.id, for: indexPath) as? NormalCaroselCollectionViewCell else {
//                    return UICollectionViewCell()
//                }
//                
//                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
//                
//                return cell
//            case .listCarousel(let item):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell else {
//                    return UICollectionViewCell()
//                }
//                
//                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
//                
//                return cell
//            }
//        })
//    }
//    
//    private func setSnapShot() {
//        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
//        
//        snapShot.appendSections([Section(id: "Banner")]) // snapShot에 똑같은 Section을 또 넣을 수는 없다. id로 구별
//        
//        let bannerItems = [
//            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: mockimage)),
//            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: mockimage)),
//            Item.banner(HomeItem(title: "BHC 치킨", imageUrl: mockimage))
//        ]
//        snapShot.appendItems(bannerItems, toSection: Section(id: "Banner"))
//        
//        snapShot.appendSections([Section(id: "Normal")]) // snapShot에 똑같은 Section을 또 넣을 수는 없다. id로 구별
//        
//        let normalItems = [
//            Item.normalCarousel(HomeItem(title: "ㅅㅅㅅㅅㅅ", subTitle: "간장치킨", imageUrl: mockimage)),
//            Item.normalCarousel(HomeItem(title: "ㅅㅅㅅㅇㅇㅅㄹㅅ", subTitle: "간장치킨", imageUrl: mockimage)),
//            Item.normalCarousel(HomeItem(title: "ㅅㅅㅅㅁㅅㅅ", subTitle: "간장치킨", imageUrl: mockimage)),
//        ]
//        snapShot.appendItems(normalItems, toSection: Section(id: "Normal"))
//        
//        snapShot.appendSections([Section(id: "List")]) // snapShot에 똑같은 Section을 또 넣을 수는 없다. id로 구별
//        
//        let listItems = [
//            Item.listCarousel(HomeItem(title: "ㅅㅅㅅㅅㅅ", subTitle: "간장치킨", imageUrl: mockimage)),
//            Item.listCarousel(HomeItem(title: "ㅅㅅㅅㅇㅇㅅㄹㅅ", subTitle: "간장치킨", imageUrl: mockimage)),
//            Item.listCarousel(HomeItem(title: "ㅅㅅㅅㅁㅅㅅ", subTitle: "간장치킨", imageUrl: mockimage)),
//        ]
//        snapShot.appendItems(listItems, toSection: Section(id: "List"))
//        
//        dataSource?.apply(snapShot)
//    }
//    
//    private func createLayout () -> UICollectionViewCompositionalLayout {
//        
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 20
//        
//        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
//            
//            switch sectionIndex {
//            case 0:
//                return self?.createBannerSection()
//            case 1:
//                return self?.createNormalSection()
//            case 2:
//                return self?.createListSection()
//            default:
//                return self?.createListSection()
//            }
//        }, configuration: config) // 섹션 스페이싱
//        
//        layout.register(BackgroundReusableView.self, forDecorationViewOfKind: BackgroundReusableView.id)
//        return layout
//    }
//    
//    private func createBannerSection() -> NSCollectionLayoutSection {
//        //item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹의 전체영역에 할당하도록 함
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        //group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//    
//    private func createNormalSection() -> NSCollectionLayoutSection {
//        //item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹의 전체영역에 할당하도록 함
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
//        //group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20) // 처음 과 끝
//        
//        return section
//    }
//    
//    private func createListSection() -> NSCollectionLayoutSection {
//        //item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        //group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3) // 그룹안에 아이템 세개가 들어가게끔
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20) // 처음 과 끝
//        
//        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: BackgroundReusableView.id)
//        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15) // 처음 과 끝
//        section.decorationItems = [backgroundItem]
//        
//        return section
//    }
//}
//
//
//// 컬렉션뷰 cell UI - 등록
//// 레이아웃 구현 - 3가지
//// datasource -> cellProvider
//// snapshot -> datasource.apply(snapshot)
//
//
//// 섹션 > 그룹 > 아이템
//
//class BackgroundReusableView: UICollectionReusableView {
//    static let id = "BackgroundReusableView"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .systemBlue.withAlphaComponent(0.2)
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
