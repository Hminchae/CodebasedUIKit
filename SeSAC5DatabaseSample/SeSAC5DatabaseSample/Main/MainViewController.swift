//
//  MainViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift
  
final class MainViewController: BaseViewController {

    private let tableView = UITableView()
    private var list: Results<TodoTable>!
    private let realm = try! Realm()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        list = realm.objects(TodoTable.self).sorted(byKeyPath: "money", ascending: true)
        print(realm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
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
        
        navigationItem.title = "고래밥 메모"
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
        
        return cell
    }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 클릭 시 묻지도 따지지도 않고 바로 삭제
        let data = realm.object(ofType: TodoTable.self, forPrimaryKey: list[indexPath.row].id)!
        //let todoToDelete = list[indexPath.row]
        // 1. 추가나 삭제 등 데이터가 바뀌면 테이블뷰도 갱신
        // 2. 왜 항상 try 구문 내에서 코드를 써야 하나?
        // 3. 테이블 컬럼이 변경되면 왜 앱이 꺼짐?
        
        try! realm.write {
            realm.delete(data)
        }
    }
}
