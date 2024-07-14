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
}

// 셀
enum Item: Hashable {
    case normal(TV)
    
}
final class HomeViewController: UIViewController {
    
    let buttonView = ButtonView()
    lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.id)
        return collectionView
    }()
    
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
        
        output.tvList.bind { tvList in
            print(tvList)
        }.disposed(by: disposeBag) // 바인딩을 해제해주어야 함, 메모리 해제
        
        output.movieList.bind { movieList in
            print(movieList)
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
            return self?.createDoubleSection()
        }, configuration: config)
    }
    
    private func createDoubleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
