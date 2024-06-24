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
import Lottie

class SearchViewController: UIViewController {
    
    private let user = UserDefaultManager.shared
    
    lazy private var searchList: [String] = user.mySearchList
    
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
    
    var list = Search(page: 0,
                      results: [],
                      total_pages: 0,
                      total_results: 0)
    
    private var searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "영화, 시리즈 등을 검색하세요"
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private var emptyView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let lottieView = LottieAnimationView()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        navigationController?.navigationBar.isHidden = true
        
        configureView()
        
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    private func configureView() {
        view.addSubview(searchBar)
        view.addSubview(emptyView)
        
        configureEmptyView()
        configureLayout()
    }
    
    private func configureEmptyView() {
        print("??")
        emptyView.addSubview(lottieView)
        
        lottieView.animation = LottieAnimation.named("empty")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .autoReverse
        
        lottieView.play()
        
        lottieView.snp.makeConstraints { make in
            make.center.equalTo(emptyView.snp.center)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(35)
        }
        
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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
                if let query = searchBar.text {
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let target = searchBar.text, !target.isEmpty, target != preSearchQuery else { return }
        
        preSearchQuery = target
        page = 1
        callRequest(query: target, page: page)
        
        emptyView.isHidden = true
        configureCollectionView()
        
        if !user.mySearchList.contains(target) {
            user.mySearchList.append(target)
        } else {
            var tempArr: [String] = user.mySearchList
            tempArr = tempArr.filter { $0 != target }
            tempArr.append(target)
            user.mySearchList = tempArr
        }
    }
}
