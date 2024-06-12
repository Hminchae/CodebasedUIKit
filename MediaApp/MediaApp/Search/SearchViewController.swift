//
//  SearchViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/11/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class SearchViewController: UIViewController {
    
    lazy var currentSearchQueryTotalPAge: Int = {
       return list.total_pages
    }()
    
    var isEnd: Bool {
        get {
            return currentSearchQueryTotalPAge == page ? true : false
        }
    }// page 가 토탈 페이지에 도달했을 때
    
    var page = 1
    var preSearchQuery: String = "" // 이전 검색 기록
    
    let popButton = UIButton()
    let searchField = UITextField()
    
    var list = Search(page: 0,
                      results: [],
                      total_pages: 0,
                      total_results: 0)
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .bg
        
        configureView()
        
        searchField.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .clear
        
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
        popButton.tintColor = .point
        popButton.addTarget(self, action: #selector(popButtonClicked), for: .touchUpInside)
        
        searchField.placeholder = " 영화를 검색하세요"
        searchField.borderStyle = .roundedRect
        searchField.tintColor = .point
        searchField.clipsToBounds = true
        searchField.layer.cornerRadius = 15
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = UIColor.point.cgColor
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
        let width = UIScreen.main.bounds.width - 15
        
        layout.itemSize = CGSize(width: width/2, height: width * 0.8)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
        
        return layout
    }
    
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func callRequest(query: String, page: Int) {
        let url = MediaAPI.movieSearch.url
        
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        
        let para: Parameters = [
            "query": query,
            "language": "ko-KR",
            "page": page
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: para,
                   headers: header)
        .responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                if self.page == 1 {
                    self.list = value // 새로운 검색어
                    self.collectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: true)
                } else {
                    self.list.results.append(contentsOf: value.results) // 기존 검색어
                }
                self.collectionView.reloadData()
                
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = searchField.text, !text.isEmpty, text != preSearchQuery else { return false }
            
        preSearchQuery = text
        page = 1
        callRequest(query: text, page: page)
        
        return true
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list.results[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        if let url = data.poster_path {
            let url = URL(string: MediaAPI.imageURL(imagePath: url).url)
            cell.mainImageView.kf.setImage(with: url)
        }
        print(data)
        return cell
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
     indexPaths.forEach { indexPath in
            if list.results.count - 2 == indexPath.row && !isEnd {
                page += 1
                if let query = searchField.text {
                    callRequest(query: query, page: page)
                }
                print(page)
            }
        }
    }
    
    // 취소기능
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소", indexPaths)
        indexPaths.forEach { indexPath in
            if let cell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell {
                cell.mainImageView.kf.cancelDownloadTask()
            }
        }
    }
}
