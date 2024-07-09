//
//  FolderViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by 황민채 on 7/8/24.
//

import UIKit

import SnapKit
import RealmSwift
import Toast

final class FolderViewController: BaseViewController {
    
    private let repository = TodoTableRepository()
    private let tableView = UITableView()
    
    var list: [Folder] = []

    private let realm = try! Realm()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        list = repository.fetchFolder()
        repository.detectRealmTable()
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
        
        navigationItem.title = "고래밥 폴더목록"
        let image = UIImage(systemName: "plus")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = data.option
        cell.overviewLabel.text = "\(data.detail.count)개의 목록"
        
        return cell
    }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        // embeded
        
        
        // 제거하는 코드
//        let data = list[indexPath.row]
//        repository.removeFolder(data)
        
        
//        let vc = MainViewController()
//        vc.folder = list[indexPath.row]
//        //vc.list = Array(list[indexPath.row].detail)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
