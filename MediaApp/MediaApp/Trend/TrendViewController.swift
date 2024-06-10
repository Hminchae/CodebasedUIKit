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
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        callRequest()
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
        
        menu.tintColor = .pointColor
        search.tintColor = .pointColor
        
        navigationItem.leftBarButtonItem = menu
        navigationItem.rightBarButtonItem = search
    }
    
    @objc func menuButtonClicked() {
        
    }
    
    @objc func searchButtonClicked() {
        
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
        tableView.rowHeight = 450 // 임시
        tableView.separatorStyle = .none
    }
    
    func callRequest() {
        let url = "\(Constants.baseUrl)/3/movie/popular"
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language" : "ko-KR",
            "time_window" : "day"
        ]
        AF.request(url, method: .get, parameters: para, headers: header).responseDecodable(of: TrendAll.self) { response in
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
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        let data = list[indexPath.row]
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.backdropPath)")

        cell.dateLabel.text = data.releaseDate
        cell.categoryLabel.text = "\(data.genreIDS.count)"
        cell.mediaImageView.kf.setImage(with: url)
        cell.trendTitleLabel.text = data.title
        cell.trendSubtitleLabel.text = data.overview
        cell.gradeBackLabel.text = "\(round(data.voteAverage * 10)/10)"
        cell.selectionStyle = .none
        
        return cell
    }
}

