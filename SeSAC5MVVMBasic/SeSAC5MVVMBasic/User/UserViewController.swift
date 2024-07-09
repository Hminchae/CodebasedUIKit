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
    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = ()
        setupUI()
        setupNavigationItems()
        bindData()
        
    }
    
    func bindData() {
        // 삭제 -> 갱신, 추가 -> 갱신
        viewModel.outputList.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
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
        viewModel.inputAddButtonTapped.value = ()
//        let randomName = generateRandomName()
//        let randomAge = Int.random(in: 18...80)
//        let newUser = User(name: randomName, age: randomAge)
//        list.append(newUser)
//        tableView.reloadData()
    }
    
    
    
    @objc private func removeAllUsers() {
//        list.removeAll()
//        tableView.reloadData()
        viewModel.inputRemoveButtonTapped.value = ()
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = viewModel.outputList.value[indexPath.row]
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
