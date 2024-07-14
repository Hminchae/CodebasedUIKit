//
//  HomeViewController.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import UIKit

import SnapKit
import RxSwift

// 레이아웃
enum Section : Hashable {
    case double
    case banner
    case horizontal(String)
    case vertical(String)
}

// 셀
enum Item: Hashable {
    case normal(Content) // 양쪽에서 쓰고 있는데..
    case bigImage(Movie)
    case list(Movie)
}

final class HomeViewController: UIViewController {
    
    let buttonView = ButtonView()
    lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.id)
        collectionView.register(BigImageCollectionViewCell.self, forCellWithReuseIdentifier: BigImageCollectionViewCell.id)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.id)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    // Subject - 이벤트를 발생 시키면서 Observable 형태도 되는 것 ➡️ 아래 1,2 두가지 목적으로 Subject를 사용
    let tvTrigger = PublishSubject<Void>()
    let movieTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        bindView()
        bindViewModel()
        tvTrigger.onNext(()) // 1️⃣ 이벤트전달
        setDataSource()
    }
    
    private func setUI() {
        view.addSubview(buttonView)
        view.addSubview(collectionView)
        
        buttonView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(buttonView.snp.bottom)
        }
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(tvTrigger: tvTrigger.asObservable(), movieTrigger: movieTrigger.asObservable()) // 2️⃣ asObservable 통해서 함수전달 💡 왜 상단에서 viewModel 인스턴스 생성한건 사용 못함?
        let output = viewModel.transform(input: input)
        
        output.tvList.bind { [weak self] tvList in
            print(tvList)
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            let items = tvList.map {  Item.normal(Content(tv: $0)) }
            let section = Section.double
            
            snapshot.appendSections([section])
            snapshot.appendItems(items, toSection: section)
            
            self?.dataSource?.apply(snapshot)
        }.disposed(by: disposeBag) // 바인딩을 해제해주어야 함, 메모리 해제
        
        output.movieList.bind { [weak self] result in
            print(result)
            switch result {
            case .success(let movieResult):
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                let bigImageList = movieResult.nowPlaying.results.map { movie in
                    return Item.bigImage(movie)
                }
                
                let bannerSection = Section.banner
                snapshot.appendSections([bannerSection])
                snapshot.appendItems(bigImageList, toSection: bannerSection)
                
                let horizontalSection = Section.horizontal("Popular movies")
                let normalList = movieResult.popular.results.map { movie in
                    return Item.normal(Content(movie: movie))
                }
                snapshot.appendSections([horizontalSection])
                snapshot.appendItems(normalList, toSection: horizontalSection)
                
                let verticalSection = Section.vertical("Upcoming movies")
                let verticalList = movieResult.upcoming.results.map { movie in
                    return Item.list(movie)
                }
                snapshot.appendSections([verticalSection])
                snapshot.appendItems(verticalList, toSection: verticalSection)
                
                self?.dataSource?.apply(snapshot)
            case.failure(let error):
                print(error)
            }
            
        }.disposed(by: disposeBag) // 바인딩을 해제해주어야 함, 메모리 해제
    }
    
    private func bindView() {
        buttonView.tvButton.rx.tap.bind { [weak self] in
            self?.tvTrigger.onNext(Void())
        }.disposed(by: disposeBag)
        
        buttonView.movieButton.rx.tap.bind { [weak self] in
            self?.movieTrigger.onNext(Void())
        }.disposed(by: disposeBag)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .double:
                return self?.createDoubleSection()
            case .banner:
                return self?.createBannerSection()
            case .horizontal:
                return self?.createHoriznotalSection()
            case .vertical:
                return self?.createVerticalSection()
            case nil:
                return self?.createDoubleSection()
            }
        }, configuration: config)
    }
    
    private func createDoubleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(640))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func createHoriznotalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // 헤더 지정
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 15, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(480))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            // 사용하려 하는 셀을 return 해주면 됨
            switch item {
            case .normal(let contentData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionViewCell.id, for: indexPath) as? NormalCollectionViewCell
                cell?.configure(title: contentData.title, review: contentData.vote, desc: contentData.overview, imageUrl: contentData.posterURL)
                
                return cell
            case .bigImage(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigImageCollectionViewCell.id, for: indexPath) as? BigImageCollectionViewCell
                cell?.configure(title: movieData.title, review: movieData.vote, desc: movieData.overview, imageUrl: movieData.posterURL)
                
                return cell
            case .list(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.id, for: indexPath) as? ListCollectionViewCell
                cell?.configure(title: movieData.title, releaseDate: movieData.releaseDate, imageUrl: movieData.posterURL)
                
                return cell
            }
        })
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .horizontal(let title):
                (header as? HeaderView)?.configure(title: title)
            case .vertical(let title):
                (header as? HeaderView)?.configure(title: title)
            default:
                print("Default")
            }
            return header
        }
    }
}
