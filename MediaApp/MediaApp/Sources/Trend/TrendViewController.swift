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

final class TrendViewController: UIViewController {
    
    private var user = UserDefaultManager.shared
    
    var list: [MovieDetail] = []
    var genres: [Genre] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trend"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureNetwork()
        configureTableView()
        configureNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        let noti = UIBarButtonItem(
            image: UIImage(systemName: "bell.fill"),
            style: .plain,
            target: self,
            action: #selector(notiButtonClicked))
        
        noti.tintColor = .point
        
        navigationItem.rightBarButtonItem = noti
        navigationItem.backButtonTitle = "" // 다음에 올 네비게이션의 백버튼 타이틀을 공백으로 변경
        self.navigationController?.navigationBar.tintColor = .point
    }
    
    @objc func menuButtonClicked() {
        //TODO: Weak/Day 전환 버튼 구현
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
            let category = await updateCategoryName(cell, genreID: data.genreIDS?[0] ?? 0)
            cell.categoryLabel.text = "#\(category)"
        }
        
        cell.dateLabel.text = data.releaseDate
        
        cell.mediaImageView.kf.setImage(with: url)
        cell.trendTitleLabel.text = data.title
        cell.trendSubtitleLabel.text = data.overview
        cell.gradeBackLabel.text = "\(round(data.voteAverage * 10)/10)"
        
        cell.selectionStyle = .none
        
        // 위시리스트(클립) 버튼 관련
        let isWishList = user.movieWishList.contains(data.id)
        setClipButtonAppearance(for: cell.clipButton, movieId: data.id)
        cell.clipButton.tag = indexPath.row
        cell.clipButton.addTarget(self, action: #selector(wishButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let data = list[indexPath.row]
        
        vc.movieId = data.id
        
        navigationController?.pushViewController(vc, animated: true)
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
    
    @objc private func wishButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        let id = list[index].id
        
        if !user.movieWishList.contains(id) {
            print("이이잉")
            user.movieWishList.append(id)
        } else {
            print("이이이")
            var tempArr = user.movieWishList
            tempArr = tempArr.filter { $0 != id }
            
            user.movieWishList = tempArr
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TrendTableViewCell {
            setClipButtonAppearance(for: sender, movieId: id)
        }
    }
    
    private func setClipButtonAppearance(for button: UIButton, movieId: Int) {
        let isWishList = user.movieWishList.contains(movieId)
        button.backgroundColor = isWishList ? .black.withAlphaComponent(0.3) : .black.withAlphaComponent(0.7)
        button.tintColor = isWishList ? .point : .white
        button.setImage(isWishList ? UIImage(systemName: "popcorn.fill") : UIImage(systemName: "popcorn"), for: .normal)
    }
}
