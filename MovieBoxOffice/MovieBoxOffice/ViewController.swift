//
//  ViewController.swift
//  MovieBoxOffice
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {

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
        button.layer.cornerRadius = 5
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
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
    
    var searchDate: String?
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dateTextField.inputView = datePicker
        
        configureViewHierachy()
        configureViewLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        dateTextField.delegate = self
        tableView.backgroundColor = .clear
        
        searchDate = todayDate
        dataRequest(searchDate)
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(isDateChanged), for: .valueChanged)
    }
    
    @objc func isDateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func searchButtonTapped() {
        if let data = dateTextField.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateStr = formatter.string(for: data)
            dataRequest(dateStr)
        }
        tableView.reloadData()
    }
    
    func configureViewHierachy() {
        view.addSubview(imageView)
        view.addSubview(bgView)
        view.addSubview(dateTextField)
        view.addSubview(underLine)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureViewLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.height.equalTo(45)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(-1)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = 50
    }
    
    func dataRequest(_ date: String?) {
        let url = "\(APIURL.baseURL)key=\(APIURL.key)&targetDt=\(date ?? "20240522")"
        
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
