//
//  MainViewController.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: 뷰
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
    
    // 뷰 하단 아이템들
    private let bottomLeftItemView = UIView()
    
    private lazy var newReminderButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.title = "새로운 미리 알림"
        configuration.image = UIImage(systemName: "plus.circle.fill")
        configuration.imagePadding = 5
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10)
        configuration.baseForegroundColor = .systemBlue
        
        button.configuration = configuration
        
        button.addTarget(self, action: #selector(newReminderButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addListButton = {
        let button = UIButton()
        button.setTitle("목록 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addListButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: override 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(bottomLeftItemView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(bottomLeftItemView.snp.top)
        }
        
        bottomLeftItemView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(10)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        setupBottomLeftItem()
    }
    
    // MARK: 일반 메서드
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
        title = "Thanky Reminder"
        
        // 서치바 설정 -> 검색 결과값으로 아예 다른 vc를 보여주도록 할 수 있음 .. 나중에 해보기
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색"
    }
    
    private func setupBottomLeftItem() {
        bottomLeftItemView.addSubview(newReminderButton)
        bottomLeftItemView.addSubview(addListButton)
        
        newReminderButton.snp.makeConstraints { make in
            make.leading.equalTo(bottomLeftItemView.snp.leading)
            make.top.equalTo(bottomLeftItemView.snp.top).offset(5)
        }
        
        addListButton.snp.makeConstraints { make in
            make.trailing.equalTo(bottomLeftItemView.snp.trailing)
            make.top.equalTo(bottomLeftItemView.snp.top).offset(5)
        }
    }
    
    // MARK: 버튼 액션
    @objc private func editButtonClicked() {
        print("편집")
    }
    
    @objc private func newReminderButtonClicked() {
        let vc = NewReminderViewController()
        present(vc, animated: true)
        print("우와")
    }
    
    @objc private func addListButtonClicked() {
        let vc = NewReminderViewController()
        present(vc, animated: true)
        print("우와22")
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
        View.MainCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let data = View.MainCategory.allCases[indexPath.row]
        cell.categoryIconImageView.image = UIImage(systemName: data.icon)
        cell.categoryIconContainer.backgroundColor = data.iconColor
        
        cell.categoryTitleLable.text = data.rawValue
        
        cell.categoryTotalToDoLabel.text = "0"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = ListDetailViewController()
        //
        //        navigationController?.pushViewController(vc, animated: true)
    }
}
