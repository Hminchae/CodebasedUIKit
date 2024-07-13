//
//  MainViewController.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/10/24.
//

import UIKit

class MainViewController: BaseViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataSource()
        setSnapShot()
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.configDetail(location: item.location,
                                  temperature: item.temperature,
                                  description: item.description,
                                  maxTemp: item.maxTemp,
                                  minTemp: item.minTemp)
                
                return cell
            case .hourlyWeather:
                return UICollectionViewCell()
            case .weeklyWeather:
                return UICollectionViewCell()
            case .precipitationMap:
                return UICollectionViewCell()
            case .etcInfo:
                return UICollectionViewCell()
            }
        })
    }
    
    private func setSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapShot.appendSections([Section(id: "Banner")]) // snapShot에 똑같은 Section을 또 넣을 수는 없다. id로 구별
        
        let bannerItems = [
            Item.banner(BannerItem(location: "동작구", temperature: 60, description: "가끔 흐림", maxTemp: 90, minTemp: 60)),
            Item.banner(BannerItem(location: "사당", temperature: 60, description: "가끔 흐림", maxTemp: 90, minTemp: 60)),
            Item.banner(BannerItem(location: "영등포", temperature: 60, description: "가끔 흐림", maxTemp: 90, minTemp: 60)),
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

