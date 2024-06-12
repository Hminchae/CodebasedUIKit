//
//  ViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class TrendViewController: UIViewController {
    
    var list: [Result] = []
    var genres: [Genre] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        callGenreRequest()
        configureTableView()
        configureNavigationItem()
    }
    
    
    func configureNavigationItem() {
        let menu = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(menuButtonClicked))
        
        let search = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonClicked))
        
        menu.tintColor = .point
        search.tintColor = .point
        
        navigationItem.leftBarButtonItem = menu
        navigationItem.rightBarButtonItem = search
        navigationItem.backButtonTitle = "" // 다음에 올 네비게이션의 백버튼 타이틀을 공백으로 변경
    }
    
    @objc func menuButtonClicked() {
        
    }
    
    @objc func searchButtonClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        tableView.rowHeight = 450 
        tableView.separatorStyle = .none
    }
    
    func callRequest() {
        let url = MediaAPI.trendURL.url
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language" : "ko-KR",
            "time_window" : "week"
        ]
        AF.request(url, method: .get, parameters: para, headers: header).responseDecodable(of: TrendMovie.self) { response in
            switch response.result {
            case .success(let value):
                print("Success")

                self.list = value.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callGenreRequest() {
        let url = MediaAPI.genreURL.url
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        AF.request(url, headers: header).responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                print("Success")
                self.genres = value.genres
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        let data = list[indexPath.row]
        let url = URL(string: MediaAPI.imageURL(imagePath: data.backdropPath).url)
        
        Task {
            let category = await updateCategoryName(cell, genreID: data.genreIDS[0])
            cell.categoryLabel.text = "#\(category)"
        }
        
        cell.dateLabel.text = data.releaseDate
        
        cell.mediaImageView.kf.setImage(with: url)
        cell.trendTitleLabel.text = data.title
        cell.trendSubtitleLabel.text = data.overview
        cell.gradeBackLabel.text = "\(round(data.voteAverage * 10)/10)"
        cell.readMoreButton.tag = indexPath.row
        cell.readMoreButton.addTarget(self, action: #selector(readMoreButtonClicked), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func updateCategoryName(_ cell: UITableViewCell, genreID: Int) async -> String {
        var result = ""
        for i in genres {
            if i.id == genreID {
                result = i.name
            }
        }
        return result
    }
    
    @objc func readMoreButtonClicked(_ sender: UIButton) {
        let id = list[sender.tag].id
        let imageUrl = list[sender.tag].backdropPath
        let overView = list[sender.tag].overview
        let vc = NewCreditViewController()
        
//        vc.targetId = id
//        vc.targetMainImageUrl = imageUrl
//        vc.targetOverView = overView
        navigationController?.pushViewController(vc, animated: true)
    }
}
