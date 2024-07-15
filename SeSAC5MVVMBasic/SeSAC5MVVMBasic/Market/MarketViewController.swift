//
//  MarketViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import UIKit

import SnapKit

class MarketViewController: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "마켓 검색"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    let viewModel = MarketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationItems()
        bindData()
        
    }
    
    func bindData() {
       viewModel.inputViewDidLoadTrigger.value = () // -> 단 한번만 통신하게 하도록 지워줘도 됨
        
        viewModel.outputMarketData.bind { _ in
            self.tableView.reloadData()
        }
        
        viewModel.outputTitleData.bind { value in
            self.navigationItem.title = value
        }
        
        viewModel.outputCellSelected.bind { data in
            
            guard let data = data else {
                print("nil 이라서 화면 전환 X, Early Exit")
                return
            }
            
            let vc = MarketDetailViewController()
            vc.viewModel.outputMarketData.value = data
            // vc.detail = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        //view.addSubview(searchBar)
        view.addSubview(tableView)
        
//        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.left.right.equalToSuperview()
//        }
        
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.left.right.bottom.equalToSuperview()
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "마켓 목록"
    }

}

extension MarketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarketData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)

        let data = viewModel.outputMarketData.value[indexPath.row]
        cell.textLabel?.text = "\(data.korean_name) | \(data.english_name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.outputMarketData.value[indexPath.row] // 뷰모델에서 데이터 가지고 오기
        
        viewModel.inputCellSelected.value = data
    }
}

extension MarketViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}
