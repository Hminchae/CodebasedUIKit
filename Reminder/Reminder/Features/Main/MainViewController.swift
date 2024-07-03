//
//  MainViewController.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
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
    
    private lazy var newReminderButton = {
        let button = UIButton()
        button.setTitle("새로운 미리알림", for: .normal)
        button.addTarget(self, action: #selector(newReminderButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(newReminderButton)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(newReminderButton.snp.top)
        }
        
        newReminderButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureNavigationItem() {
        // 네비게이션 바 아이템 설정
        let edit = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(editButtonClicked))
        
        navigationItem.rightBarButtonItem = edit
        
        // 네비게이션 타이틀 설정
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "전체"
        
        // 서치바 설정
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색"
    }
    
    @objc private func editButtonClicked() {
        print("편집")
    }
    
    @objc private func newReminderButtonClicked() {
        let vc = NewReminderViewController()
        present(vc, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("우웨에에엥엑")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            return 300 // 여기에 list / 2 + 1 * 100 만큼 ..?
        case 1:
            return 40
        default:
            return 0
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
//        let vc = ListDetailViewController()
//        
//        navigationController?.pushViewController(vc, animated: true)
    }
}
