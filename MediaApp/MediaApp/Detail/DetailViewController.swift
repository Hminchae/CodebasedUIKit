//
//  SearchDetailViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

import Kingfisher

class DetailViewController: BaseViewController {
    
    var movieId: Int?
    var imagePath: String?
    
    lazy private var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.register(DetailPosterTableViewCell.self,
                           forCellReuseIdentifier: DetailPosterTableViewCell.identifier)
        return tableView
    }()
    
    var detailImageList: [[SearchResult]] = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNetwork()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .bg
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .point
    }
    
    private func configureNetwork() {
        guard let movieId = movieId else { return }
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.searchCallRequest(
                api: .movieSimilar(movieId: movieId)
            ) { result in
                switch result {
                case .success(let value):
                    print(value)
                    self.detailImageList[0] = value.results
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.searchCallRequest(
                api: .movieRecommend(movieId: movieId)
            ) { result in
                switch result {
                case .success(let value):
                    self.detailImageList[1] = value.results
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 350
        case 1:
            return 200
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return detailImageList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPosterTableViewCell.identifier, for: indexPath) as! DetailPosterTableViewCell
           
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = indexPath.row
            cell.collectionView.register(DetailPosterCollectionCell.self, forCellWithReuseIdentifier: DetailPosterCollectionCell.identifier)
            cell.collectionView.reloadData()
            cell.collectionView.backgroundColor = .bg
            cell.collectionView.indicatorStyle = .black
            
            return cell
        case 1: 
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = indexPath.row
            cell.collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
            cell.collectionView.reloadData()
            cell.collectionView.backgroundColor = .bg
            cell.collectionView.indicatorStyle = .black
            
            if indexPath.row == 0 {
                cell.titleLabel.text = "비슷한 영화"
            } else if indexPath.row == 1 {
                cell.titleLabel.text = "추천하는 영화"
            }
            
            return cell
        default:
            fatalError("error")
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // 임시
        case 1:
            return detailImageList[collectionView.tag].count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPosterCollectionCell.identifier, for: indexPath) as! DetailPosterCollectionCell
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPosterCollectionCell.identifier, for: indexPath) as! DetailPosterCollectionCell
            
            if let imagePath = imagePath {
                let url = URL(string: MediaAPI.imageURL(imagePath: imagePath).entireUrl)
                cell.posterHeaderImageView.kf.setImage(with: url)
            }
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
            
            let data = detailImageList[collectionView.tag][indexPath.row]
            if let imageUrl = data.poster_path {
                let url = URL(string: MediaAPI.imageURL(imagePath: imageUrl).entireUrl)
                cell.posterImageView.kf.setImage(with: url)
            }
            
            return cell
            
        default:
            fatalError("error")
        }
    }
}
