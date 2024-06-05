//
//  ViewController.swift
//  MovieBoxOffice
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

class ViewController: UIViewController {

    let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "bgImage")
        
        return imageView
    }()
    
    let bgView = {
        let bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.8)
        
        return bgView
    }()
    
    let dateTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "검색하고 싶은 날짜를 입력해주세요"
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 15)
        
        return textField
    }()
    
    let searchButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("검색", for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    let underLine = {
        let line = UIView()
        line.backgroundColor = .white
        
        return line
    }()
    
    let todayDate = {
        let date = Date(timeIntervalSinceNow: -86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateStr = dateFormatter.string(for: date)
        
        return dateStr
    }()
    
    var list: [BoxOffice] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureViewHierachy()
        configureViewLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        dataRequest()

    }
    
    func configureViewHierachy() {
        view.addSubview(imageView)
        view.addSubview(bgView)
        view.addSubview(tableView)
    }
    
    func configureViewLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = 50
    }
    
    func dataRequest() {
        let url = "\(APIURL.baseURL)key=\(APIURL.key)&targetDt=\(todayDate ?? "20240522")"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                print("success")
                self.list = value.boxOfficeResult.dailyBoxOfficeList
                print(self.list)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        cell.backgroundColor = .clear
        cell.rankingLabel.text = list[indexPath.row].rank
        cell.movieTitleLabel.text = list[indexPath.row].movieNm
        cell.openDateLabel.text = list[indexPath.row].openDt
        
        return cell
    }
}

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOfficeDetails
}

struct BoxOfficeDetails: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOffice]
}

struct BoxOffice: Decodable {
    let openDt: String
    let movieNm: String
    let rank: String
}
