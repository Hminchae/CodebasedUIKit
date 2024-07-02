//
//  MainView.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

class MainView: BaseView {
    
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    lazy private var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTopTableViewCell.self,
                           forCellReuseIdentifier: MainTopTableViewCell.identifier)
        tableView.register(MainBottomTableViewCell.self,
                           forCellReuseIdentifier: MainBottomTableViewCell.identifier)
        
        return tableView
    }()
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(35)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        searchBar.placeholder = "검색"
        searchBar.delegate = self
        
        tableView.backgroundColor = .bg
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension MainView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("우웨에에엥엑")
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTopTableViewCell.identifier, for: indexPath)
            guard let cell = cell as? MainTopTableViewCell else { return UITableViewCell() }
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = 100
            cell.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainBottomTableViewCell.identifier, for: indexPath)
            guard let cell = cell as? MainBottomTableViewCell else { return UITableViewCell() }
            cell.toDoCountLabel.text = "0"
            cell.toDoTitleLabel.text = "어렵다.."
            cell.accessoryType = .disclosureIndicator
            
            return cell
        default:
            return UITableViewCell()
        }
    } 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 1:
            return 40
        default:
            return 0
        }
    }
    
}

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.categoryIconImageView.image = UIImage(systemName: "star")
        cell.categoryIconImageView.backgroundColor = .blue
        
        cell.categoryTitleLable.text = "전체"
        
        cell.categoryTotalToDoLabel.text = "0"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("에에")
    }
}
