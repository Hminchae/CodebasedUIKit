//
//  UserViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by jack on 7/9/24.
//

import UIKit
import SnapKit

struct User {
    let name: String
    let age: Int
}

class UserViewController: UIViewController {
    
    private var list: [User] = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "이름으로 검색"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItems()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "사용자 목록"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRandomUser))
        let removeAllButton = UIBarButtonItem(title: "전체 제거", style: .plain, target: self, action: #selector(removeAllUsers))
        
        navigationItem.rightBarButtonItems = [addButton, removeAllButton]
    }
    
    @objc private func addRandomUser() {
        let randomName = generateRandomName()
        let randomAge = Int.random(in: 18...80)
        let newUser = User(name: randomName, age: randomAge)
        list.append(newUser)
        tableView.reloadData()
    }
    
    private func generateRandomName() -> String {
        let firstNames = ["John", "Jane", "Mike", "Emily", "David", "Sarah", "Chris", "Anna"]
        let lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Wilson"]
        
        let randomFirstName = firstNames.randomElement() ?? ""
        let randomLastName = lastNames.randomElement() ?? ""
        
        return "\(randomFirstName) \(randomLastName)"
    }
    
    @objc private func removeAllUsers() {
        list.removeAll()
        tableView.reloadData()
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = list[indexPath.row]
        cell.textLabel?.text = "\(user.name) (\(user.age)세)"
        return cell
    }
}

extension UserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}
