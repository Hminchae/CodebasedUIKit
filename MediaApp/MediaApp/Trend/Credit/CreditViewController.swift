//
//  CreditViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class CreditViewController: UIViewController {
    
    var targetId: Int?
    var targetMainImageUrl: String?
    var targetOverView: String?
    var list: [Cast] = []
    
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    lazy private var mainImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleToFill
        //v.clipsToBounds = true
        
        if let imageUrl = targetMainImageUrl {
            let url = URL(string: MediaAPI.imageURL(imagePath: imageUrl).url)
            v.kf.setImage(with: url)
        }
        
        return v
    }()
    
    private let overViewTitleLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.textColor = .gray
        v.text = "OverView"
        
        return v
    }()
    
    private let firstSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        
        return v
    }()
    
    lazy private var overViewLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .white
        v.text = targetOverView
        v.textAlignment = .left
        
        return v
    }()
    
    lazy private var expandableButton: UIButton = {
        let v = UIButton()
        v.tintColor = .white
        v.addTarget(self, action: #selector(expandableButtonClicked), for: .touchUpInside)
        
        return v
    }()
    
    private let secondSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        
        return v
    }()
    
    private let castTitleLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.textColor = .gray
        v.text = "Cast"
        
        return v
    }()
    
    var isExpandable: Bool = false
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .bg
        navigationItem.title = "출연/제작"
        self.navigationController?.navigationBar.tintColor = .point// 백버튼의 틴트 색상을 변경
        //print(targetId)
        if let targetId = targetId {
            callRequest(targetId)
        }
        configureView()
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CreditTableViewCell.self, forCellReuseIdentifier: CreditTableViewCell.identifier)
        
        tableView.rowHeight = 45
        tableView.separatorStyle = .none
    }
    
    func configureView() {
        view.addSubview(mainImageView)
        view.addSubview(overViewTitleLabel)
        view.addSubview(firstSeparator)
        view.addSubview(overViewLabel)
        view.addSubview(expandableButton)
        view.addSubview(secondSeparator)
        view.addSubview(castTitleLabel)
        view.addSubview(tableView)
        
        configureLayout()
        configureExpandableView()
    }
    
    func configureExpandableView() {
        isExpandable ? expandableButton.setImage(UIImage(systemName: "chevron.up"), for: .normal) : expandableButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        overViewLabel.numberOfLines = isExpandable ? 0 : 2
    }
    
    @objc func expandableButtonClicked() {
        isExpandable.toggle()
        configureExpandableView()
        overViewLabel.snp.removeConstraints()
        configureExpandLayout()
    }
    
    func configureExpandLayout() {
        if !isExpandable {
            overViewLabel.snp.makeConstraints { make in
                make.top.equalTo(firstSeparator.snp.bottom).offset(10)
                make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(25)
                make.height.equalTo(30)
            }
        } else {
            overViewLabel.snp.makeConstraints { make in
                make.top.equalTo(firstSeparator.snp.bottom).offset(10)
                make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(25)
                make.height.equalTo(60)
            }
        }
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)//.offset(60)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
        }
        
        overViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.height.equalTo(20)
        }
        
        firstSeparator.snp.makeConstraints { make in
            make.top.equalTo(overViewTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(0.8)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(firstSeparator.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(25)
            make.height.equalTo(60)
        }
        
        expandableButton.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(secondSeparator.snp.top).offset(-10)
            make.height.equalTo(20)
        }
        
        secondSeparator.snp.makeConstraints { make in
            make.top.equalTo(expandableButton.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(0.8)
        }
        
        castTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(secondSeparator.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.height.equalTo(17)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(castTitleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(view.snp.bottom)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
        }
    }
    
    func callRequest(_ id: Int) {
        let url = MediaAPI.creditURL(movieId: id).url
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language" : "ko-KR",
        ]
        AF.request(url, method: .get, parameters: para, headers: header).responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                print("Success")
                //print(value.cast)
                self.list = value.cast
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CreditViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        print(list[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier, for: indexPath) as! CreditTableViewCell
        if let url = list[indexPath.row].profilePath {
            let url = URL(string: MediaAPI.imageURL(imagePath: url).url)
            cell.actorProfieImageView.kf.setImage(with: url)
        }
        cell.actorName.text = list[indexPath.row].originalName
        cell.roleName.text = list[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
}
