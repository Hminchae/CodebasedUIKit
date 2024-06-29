//
//  SearchDetailViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

import SnapKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    var movieId: Int?

    lazy var movieTitle = ""
    lazy var movieOverView = ""
    var movieLogoPath: String?
    
    lazy private var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        return tableView
    }()
    
    var detailImageList: [[SearchResult]] = [[], []]
    var posterImageList: [PosterBackdrop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewHeader()
        configureNetwork()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let topSafeArea = view.safeAreaInsets.top
        
        tableView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(-topSafeArea)
            make.bottom.equalTo(view.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .bg
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .point
    }
    
    func setupTableViewHeader() {
        let headerView = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 450))
        headerView.collectionView.dataSource = self
        headerView.collectionView.tag = 100
        tableView.tableHeaderView = headerView
    }
    
    private func configureNetwork() {
        guard let movieId = movieId else { return }
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.detailMovieCallRequest(api: .movieDetail(movieID: movieId)
            ) { result in
                switch result {
                case .success(let value):
                    if let title = value.title {
                        self.movieTitle = title
                    }
                    self.movieOverView = value.overview
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.searchCallRequest(
                api: .movieSimilar(movieId: movieId)
            ) { result in
                switch result {
                case .success(let value):
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
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.moviePosterCallRequest(
                api: .moviePoster(movieId: movieId)
            ) { result in
                switch result {
                case .success(let value):
                    self.posterImageList = value.backdrops
                    self.movieLogoPath = value.logos[0].file_path
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            if let headerView = self.tableView.tableHeaderView as? DetailHeaderView {
                headerView.collectionView.reloadData()
                headerView.pageControl.numberOfPages = self.posterImageList.count
            }
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100 {
            return posterImageList.count
        } else {
            return detailImageList[collectionView.tag].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 100 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailHeaderCollectionCell.identifier, for: indexPath) as! DetailHeaderCollectionCell
            let data = posterImageList[indexPath.row]
            
            let url = URL(string: MediaAPI.imageURL(imagePath: data.file_path).entireUrl)
            cell.posterHeaderImageView.kf.setImage(with: url)
            
            cell.movieTitleLabel.text = movieTitle
            cell.movieOverViewLabel.text = movieOverView
            
            if let logoPath = movieLogoPath  {
                let logoUrl = URL(string: MediaAPI.imageURL(imagePath: logoPath).entireUrl)
                cell.movieLogoImageView.kf.setImage(with: logoUrl)
            }
            
            if indexPath.row == 0 {
                cell.isVisibleOverView = true
            } else {
                cell.isVisibleOverView = false
            }
            
            return cell
        }  else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
            let data = detailImageList[collectionView.tag][indexPath.row]
            
            if let imageUrl = data.poster_path {
                let url = URL(string: MediaAPI.imageURL(imagePath: imageUrl).entireUrl)
                cell.posterImageView.kf.setImage(with: url)
            }
            
            return cell
        }
    }
}
