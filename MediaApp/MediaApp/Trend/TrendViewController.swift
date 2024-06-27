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
    
    var list: [MovieDetail] = []
    var genres: [Genre] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        
        configureNetwork()
        configureTableView()
        configureNavigationItem()
    }
    
    func configureNetwork() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.trendMovieCallRequest(api: .trendURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        self.list = value.results
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.genreCallRequest(api: .genreURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        self.genres = value.genres
                    case .failure(let error):
                        print(error)
                    }
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func configureNavigationItem() {
        let menu = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(menuButtonClicked))
        
        let noti = UIBarButtonItem(
            image: UIImage(systemName: "bell.fill"),
            style: .plain,
            target: self,
            action: #selector(notiButtonClicked))
        
        menu.tintColor = .point
        noti.tintColor = .point
        
        navigationItem.leftBarButtonItem = menu
        navigationItem.rightBarButtonItem = noti
        navigationItem.backButtonTitle = "" // 다음에 올 네비게이션의 백버튼 타이틀을 공백으로 변경
        self.navigationController?.navigationBar.tintColor = .point
    }
    
    @objc func menuButtonClicked() {
        //TODO: 영화와 드라마 전환 버튼 구현
    }
    
    @objc func notiButtonClicked() {
        //TODO: 알림모아보기 구현
    }
    
    func configureTableView() {
        view.backgroundColor = .bg
        view.addSubview(tableView)
   
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        tableView.rowHeight = 450
        tableView.separatorStyle = .none
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        let data = list[indexPath.row]
        let url = URL(string: MediaAPI.imageURL(imagePath: data.backdropPath).entireUrl)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = list[indexPath.row].id
        let imageUrl = list[indexPath.row].backdropPath
        let overView = list[indexPath.row].overview
        let vc = DetailViewController()
        vc.movieId = id
        vc.imagePath = imageUrl
        vc.movieName = list[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true)
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
        
    }
}
