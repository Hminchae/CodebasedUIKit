//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    let list = SettingSet.tamaSettingSet
    let tableView = UITableView()
    let user = UserDefaultManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        title = "설정"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        configureLayout()
    }
    
    // 이름변경 후 돌아올때 버벅이는 문제 해결: 0번셀만 재 렌더링
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.rowHeight = 50
        tableView.backgroundColor = .clear
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator // 셀 악세서리 스타일 적용
        
        cell.icon.image = UIImage(systemName: list[indexPath.row].settingIcon)
        cell.settingName.text = list[indexPath.row].settingName
        
        if indexPath.row == 0 {
            cell.detailName.text = "\(user.captainName)님"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = SettingNameViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            user.tamaChangedState = true
            let vc = TamagotchisViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            // 1.
            let alert = UIAlertController(
                title: "데이터 초기화",
                message: "정말 다시 처음부터 시작하실 건가용?",
                preferredStyle: .alert)
            // 2.
            let cancel = UIAlertAction(
                title: "아냐!",
                style: .cancel)
            let open = UIAlertAction(
                title: "웅",
                style: .default) { action in
                    print(self.user.tamagotchiType)
                    self.user.captainName = "대장"
                    self.user.rice = 0
                    self.user.waterDrop = 0
                    self.user.tamagotchiType = 0
                    self.user.tamaChangedState = false
                    print(self.user.tamagotchiType)
                }
            // 3.
            alert.addAction(cancel)
            alert.addAction(open)
            // 4.
            present(alert, animated: true)
        default:
            print("확인")
        }
        // 테이블셀 선택된 이후 색상 돌아오도록하는 메서드
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingViewController: UITableViewDelegate { }

