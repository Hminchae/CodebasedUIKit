//
//  PosterViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

import SnapKit
import Kingfisher

/*
 컴파일 최적화 : 서로 파일/코드가 영향이 없게. 필요한 것들만 연결고리가 만들어지게 하여야 함!
 - final : 클래스에 대한 상속 X 재정의가 안 된다는 것
 - 접근 제어 : Private
 => Method Dispatch (static Dispatch / Dynamic Dispatch)
 */

final class PosterViewController: BaseViewController {
    
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
        //TMDBManager.shared.callRequest(completionHandler: (Lotto?, thankyError?) -> Void)
        TMDBManager.shared.callRequest { lotto, error in
            if let error = error {
                print("에러~~")
            } else if let lotto = lotto {
                print(lotto)
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() +2 ) { 💡의도적으로 시간을 두고 갱신을 하는 방법도 있음
//            tableView.reloadData()
//        }
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
    
//    func configurePosterImage() {
//        let group = DispatchGroup()
//        
//        group.enter()
//        DispatchQueue.global().async(group: group) {
//            NetworkManager.shared.trending(api: .trendingMovie) { movies, error in
//                if let error = error {
//                    print("영화 로딩 중 에러 발생: \(error)")
//                } else if let movies = movies {
//                    self.imageList[0] = movies
//                }
//                group.leave()
//            }
//        }
//        
//        group.enter()
//        DispatchQueue.global().async(group: group) {
//            NetworkManager.shared.trending(api: .trendingTV) { tvShows, error in
//                if let error = error {
//                    print("error")
//                } else if let tvShow = tvShows { // 첫 번째 TV 쇼를 가져옵니다.
//                    self.imageList[1] = tvShow // 두 번째 인덱스에 TV 쇼 포스터 할당
//                }
//                group.leave()
//            }
//        }
//        
//        group.notify(queue: .main) {
//            self.tableView.reloadData()
//            print("네트워크 작업 완료 ❤️")
//        }
//    }
    
    func aboutGCD() { // Dynamic dispatch > (final 클래스가 된 이후) static dispatch
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
        
//        if indexPath.row == 0 {
//            cell.titleLabel.text = "트렌드 영화"
//        } else if indexPath.row == 1 {
//            cell.titleLabel.text = "트렌드 시리즈"
//        }
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
