//
//  PosterViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

import SnapKit
import Kingfisher

class PosterViewController: BaseViewController {
    
    // ✅ self 때문에, 미리 생성되지 않도록 lazy를 사용해줌
    lazy var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        
        return tableView
    }()
    
    //    var imageList: [[String]] = [
    //    ["star", "person", "xmark", "star.fill", "heart"],
    //    ["star.fill", "person", "xmark", "star.fill", "heart"],
    //    ["person", "person", "xmark", "star.fill", "heart"]
    //    ]
    
    var imageList: [[MovieDetail]] = [[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePosterImage()
        
        //aboutGCD()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
    func configurePosterImage() {
        let group = DispatchGroup()
        
        group.enter() //+1
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.trendMovieCallRequest { result in
                switch result {
                case .success(let value):
                    self.imageList[0] = value.results
                    print("11111111111")
                case .failure(let error):
                    print(error)
                }
                group.leave() // -1
            }
        }
        
        group.enter() //+2
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.trendTVCallRequest { result in
                switch result {
                case .success(let value):
                    self.imageList[1] = value.results
                    print("2222222222222")
                case .failure(let error):
                    print(error)
                }
                group.leave() // -1
            }
        }
        
        // 0 일때..비로소
        group.notify(queue: .main) {
            self.tableView.reloadData()
            print("네트워크 알바생 업무 끝났어용 ❤️")
        }
    }
    
    // serial, concurrent, / sync async
    // main global
    // global qos
    // dispatchgroup
    
    func aboutGCD() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for item in 1...100 {
                print(item, terminator: "💚")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for item in 101...200 {
                print(item, terminator: "🧡")
            }
        }
        
        DispatchQueue.global().async(group: group)  {
            for item in 201...300 {
                print(item, terminator: "🩵")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for item in 301...400 {
                print(item, terminator: "💙")
            }
        }
        
        group.notify(queue: .main) {
            print("알바생 업무 끝났어용 ❤️")
        }
    }
}


extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        cell.collectionView.reloadData()
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "트렌드 영화"
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "트렌드 시리즈"
        }
        return cell
    }
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        
        let data = imageList[collectionView.tag][indexPath.row]
        let url = URL(string: MediaAPI.imageURL(imagePath: data.poster_path).url)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
