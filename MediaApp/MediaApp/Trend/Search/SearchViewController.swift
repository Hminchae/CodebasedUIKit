//
//  SearchViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/11/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let popButton = UIButton()
    let searchField = UITextField()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        configureView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func configureView() {
        view.addSubview(popButton)
        view.addSubview(searchField)
        view.addSubview(collectionView)
        
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        popButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        popButton.tintColor = .pointColor
        popButton.addTarget(self, action: #selector(popButtonClicked), for: .touchUpInside)
        
        searchField.placeholder = " 영화를 검색하세요"
        searchField.borderStyle = .roundedRect
        searchField.tintColor = .pointColor
        searchField.clipsToBounds = true
        searchField.layer.cornerRadius = 15
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = UIColor.pointColor?.cgColor
    }
    
    private func configureLayout() {
        popButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.size.equalTo(25)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(popButton.snp.trailing).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(35)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        
        layout.itemSize = CGSize(width: width/3, height: width/3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
    
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        return cell
    }
}
