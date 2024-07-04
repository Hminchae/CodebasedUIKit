//
//  SearchViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by 황민채 on 7/4/24.
//

import UIKit

import RealmSwift
import SnapKit

final class SearchViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "검색하시오."
        return searchBar
    }()
    
    let realm = try! Realm()
    var list: Results<TodoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(TodoTable.self)
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function, searchBar.text, searchText)
        let filtered = realm.objects(TodoTable.self)
            .where { $0.momoTitle.contains(searchText, options: .caseInsensitive) } // caseInsensitive 대소문자 구분없이 검색
        let result = searchText.isEmpty ? realm.objects(TodoTable.self) : filtered
        list = filtered
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate,
                                UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let index = indexPath.row
        let item = list[index]
        
        cell.titleLabel.text = item.momoTitle
        cell.subTitleLabel.text = item.category
        cell.overviewLabel.text = "\(item.money.formatted())"
        cell.thumbnailImageView.image = loadImageToDocument(filename: "\(item.id)")
        return cell
    }
    
    
}
