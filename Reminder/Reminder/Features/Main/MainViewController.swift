//
//  MainViewController.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: 뷰
    private lazy var tableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainBodyTableViewCell.self,
                           forCellReuseIdentifier: MainBodyTableViewCell.identifier)
        
        return tableView
    }()
    
    // 뷰 하단 아이템들
    private let bottomItemView = UIView()
    
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
        view.addSubview(bottomItemView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.bottom.equalTo(bottomItemView.snp.top)
        }
        
        bottomItemView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(10)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        setupTableViewHeader()
        setupBottomItemView()
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
        navigationItem.backButtonTitle = "목록"
        // 네비게이션 타이틀 설정
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Thanky Reminder"
        
        // 서치바 설정 -> 검색 결과값으로 아예 다른 vc를 보여주도록 할 수 있음 .. 나중에 해보기
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색"
    }
    
    private func setupBottomItemView() {
        bottomItemView.addSubview(newReminderButton)
        bottomItemView.addSubview(addListButton)
        
        newReminderButton.snp.makeConstraints { make in
            make.leading.equalTo(bottomItemView.snp.leading)
            make.top.equalTo(bottomItemView.snp.top).offset(5)
        }
        
        addListButton.snp.makeConstraints { make in
            make.trailing.equalTo(bottomItemView.snp.trailing)
            make.top.equalTo(bottomItemView.snp.top).offset(5)
        }
    }
    
    func setupTableViewHeader() {
        let headerView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 300))
        headerView.collectionView.delegate = self
        headerView.collectionView.dataSource = self
        tableView.tableHeaderView = headerView
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainBodyTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? MainBodyTableViewCell else { return UITableViewCell() }
        cell.categoryIconContainer.backgroundColor = .red
        cell.toDoCountLabel.text = "0"
        cell.toDoTitleLabel.text = "어렵다.."
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        View.MainCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainHeaderCollectionViewCell.identifier, for: indexPath) as? MainHeaderCollectionViewCell else { return UICollectionViewCell() }
        
        let data = View.MainCategory.allCases[indexPath.row]
        
        cell.categoryIconImageView.image = UIImage(systemName: data.icon)
        cell.categoryIconContainer.backgroundColor = data.iconColor
        
        cell.categoryTitleLable.text = data.rawValue
        
        cell.categoryTotalToDoLabel.text = "0"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("bnbbb")
        let vc = ListDetailViewController()
        vc.navigationTitle = View.MainCategory.allCases[indexPath.row].rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
}
