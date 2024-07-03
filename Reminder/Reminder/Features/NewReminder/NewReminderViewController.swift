//
//  NewReminderViewController.swift
//  Reminder
//
//  Created by 황민채 on 7/2/24.
//

import UIKit

import RealmSwift

protocol NewReminderContentsDelegate {
    func passTitle(_ text: String)
    func passMemo(_ text: String)
}

class NewReminderViewController: BaseViewController {
    
    lazy private var tableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewReminderContentsTableViewCell.self,
                           forCellReuseIdentifier: NewReminderContentsTableViewCell.identifier)
        tableView.register(TitleTableViewCell.self,
                           forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var addButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        button.tintColor = .label
        
        return button
    }()
    
    private lazy var cancelButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private var tempReminder: Reminder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempReminder = Reminder(title: "", category: .reminder)
    }
    
    override func configureHierarchy() {
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        cancelButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addButtonClicked() {
        let realm = try! Realm() // 데이터가 있는 위치를 찾아가는 코드

        guard let reminder = tempReminder, !reminder.title.isEmpty else {
            let alert = UIAlertController(title: "제목이 비어 있습니다", message: "제목을 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            
            return
        }
        
        let data = TodoTable(momoTitle: reminder.title, memoContent: reminder.memo)
        try! realm.write {
            realm.add(data)
            print("Realm Create Succeed")
        }
        
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonClicked() {
        dismiss(animated: true)
    }
}

extension NewReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return View.NewREList.allCases.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewReminderContentsTableViewCell.identifier, for: indexPath)
            guard let cell = cell as? NewReminderContentsTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath)
            guard let cell = cell as? TitleTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = View.NewREList.allCases[indexPath.row].rawValue
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 180
        case 1:
            return 50
        default:
            return 0
        }
    }
}

extension NewReminderViewController: NewReminderContentsDelegate {
    func passTitle(_ text: String) {
        print(#function, text)
        tempReminder?.title = text
    }
    
    func passMemo(_ text: String) {
        tempReminder?.memo = text
    }
}
