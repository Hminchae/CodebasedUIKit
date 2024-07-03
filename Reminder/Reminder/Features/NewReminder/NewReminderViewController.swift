//
//  NewReminderViewController.swift
//  Reminder
//
//  Created by 황민채 on 7/2/24.
//

import UIKit

import RealmSwift

class NewReminderViewController: BaseViewController {

    lazy private var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewReminderContentsTableViewCell.self,
                           forCellReuseIdentifier: NewReminderContentsTableViewCell.identifier)
        tableView.register(NewReminderDetailTableViewCell.self,
                           forCellReuseIdentifier: NewReminderDetailTableViewCell.identifier)
        
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
    
    let titleTextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.font = REFont.m12
        textField.tintColor = .darkGray
        textField.textColor = .label
        
        return textField
    }()
    
    let separatorView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    let memoTextField = {
        let textField = UITextField()
        textField.placeholder = "메모"
        textField.font = REFont.m12
        textField.tintColor = .darkGray
        textField.textColor = .label
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        
        view.addSubview(titleTextField)
        view.addSubview(separatorView)
        view.addSubview(memoTextField)
        
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
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(10)
            make.top.equalTo(addButton.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(10)
            make.top.equalTo(titleTextField.snp.bottom)
            make.height.equalTo(1)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(10)
            make.top.equalTo(separatorView.snp.bottom)
            make.height.equalTo(150)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(memoTextField.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addButtonClicked() {
        let realm = try! Realm() // 데이터가 있는 위치를 찾아가는 코드
        
        guard let title = titleTextField.text, !title.isEmpty,
              let memo = memoTextField.text
        else {
            // 1.
            let alert = UIAlertController(
                title: "제목이 비어있습니다!!",
                message: "제목은 옵셔널이 아니라서 입력해야합니다ㅡㅡ",
                preferredStyle: .alert)
            
            // 2.
            let confirm = UIAlertAction(
                title: "확인",
                style: .default)
            
            // 3.
            alert.addAction(confirm)
            
            // 4.
            present(alert, animated: true)
            return
        }
        
        let data = TodoTable(momoTitle: title, memoContent: memo)
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
   
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewReminderDetailTableViewCell.identifier, for: indexPath)
            guard let cell = cell as? NewReminderDetailTableViewCell else { return UITableViewCell() }
            cell.listTitleLabel.text = View.NewREList.allCases[indexPath.row].rawValue
            
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
            return 30
        default:
            return 0
        }
    }
}
