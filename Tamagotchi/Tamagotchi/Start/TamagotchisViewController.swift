//
//  TamagotchisViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit
import SnapKit

class TamagotchisViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(TamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: TamagotchiCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let topTitle: UILabel = {
        let v = UILabel()
        v.text = "다마고찌 선택하기"
        v.font = .boldSystemFont(ofSize: 17)
        v.textColor = .black
        v.textAlignment = .center
        
        return v
    }()
    
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        configureUI()
    }
    
    func configureUI() {
        print(#function)
        view.addSubview(topTitle)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        print(#function)
        topTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    let list: [Tamagotchi] = TamagotchiSet.tamagotchiSet
}

extension TamagotchisViewController: UICollectionViewDelegate {
    
}

extension TamagotchisViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.identifier, for: indexPath) as? TamagotchiCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .clear
        
        let model = list[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        let vc = TamagotchiStartViewController()
        vc.tamagotchiInfo = data
        if data.description != nil {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            
            present(vc, animated: true)
        }
    }
}

extension TamagotchisViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100 // 너비 고정값
        let height = 135 // 높이 고정값

        return CGSize(width: width, height: height)
    }
}


