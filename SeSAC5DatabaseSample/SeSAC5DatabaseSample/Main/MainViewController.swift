//
//  MainViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift
import Toast

final class MainViewController: BaseViewController {
    
    private let repository = TodoTableRepository()
    private let tableView = UITableView()
    
    var folder: Folder?
    var list: [TodoTable] = []
    
    private let realm = try! Realm()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        if let folder = folder {
            let value = folder.detail
            list = Array(value)
        }
        repository.detectRealmTable()
        
        guard let folder else { return }
        navigationItem.title = folder.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
         
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item

    }
    
    override func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.folder = folder
        vc.showToast = {
            self.view.makeToast("일기가 저장되었습니다.")
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        cell.titleLabel.text = data.momoTitle
        cell.subTitleLabel.text = data.category
        cell.overviewLabel.text = data.money.formatted() + "원"
        cell.thumbnailImageView.image = loadImageToDocument(filename: "\(data.id)")
        return cell
    }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 클릭 시 묻지도 따지지도 않고 바로 삭제
        // let data = realm.object(ofType: TodoTable.self, forPrimaryKey: list[indexPath.row].id)!
        // ⬆️ PK ? 중복 X, 고유, nil X, Index 특성
        //let todoToDelete = list[indexPath.row]
        // realm.deleate(todoToDelete)
        // ⬆️ list 를 제거하더라도 realm까지 변경 사항이 반영됨
        
        // 1. 추가나 삭제 등 데이터가 바뀌면 테이블뷰도 갱신
        // 2. 왜 항상 try 구문 내에서 코드를 써야 하나? transaction
        // 3. 테이블 컬럼이 변경되면 왜 앱이 꺼짐?
        /*
        try! realm.write {
            realm.delete(data)
        }
        tableView.reloadData()
        */
        
        // 🧶 07-04
        let data = list[indexPath.row]
        // 렘을 제거하면 파일을 먼저!!!같이 제거해주어야 한다!
        removeImageFromDocument(filename: "\(data.id)")
//        try! realm.write {
//            // list 를 제거하더라도 realm까지 변경 사항이 반영된다.
//            realm.delete(list[indexPath.row])
//            
//        }
       // repository.deleteItem(data) <- 이거 삭제임🗑️
        let realm = try! Realm()
//        
//        try! realm.write {
//            realm.create(TodoTable.self,
//                         value: ["id": data.id,
//                                 "money": 1000000000000000000],
//                         update:  .modified)
//        }
//        
        // 수정하고 싶은 데이터가 여러레코드라면?
        
        let result = realm.objects(TodoTable.self)
        
        try! realm.write {
            result.setValue(true, forKey: "love")
        }
        
        tableView.reloadData()
    }
}
