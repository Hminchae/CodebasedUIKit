//
//  MyPageViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let myPageSettingList = [["알림 설정", "자주 묻는 질문", "1:1 문의"], ["초기화 하기"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Page"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 40
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return myPageSettingList[0].count
        case 1:
            return myPageSettingList[1].count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myPageSettingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? MyPageTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        
        cell.backgroundColor = .container
        cell.titleLabel.text = myPageSettingList[indexPath.section][indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
