//
//  SearchDetailViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

class DetailViewController: UIViewController {
    private let tableView = UITableView()
    
    private let sectionTitles: [String] = ["비슷한 영화", "추천하는 영화"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.register(DetailCollectionTableViewCell.self, forCellReuseIdentifier: DetailCollectionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.tableHeaderView = headerView
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCollectionTableViewCell.identifier, for: indexPath) as? DetailCollectionTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case Detail.Sections.recommendMovies.rawValue:
            NetworkManager.shared.recommendCallRequest(id: 683722, page: 1) { result in
                DispatchQueue.main.async {
                    self.setTableViewAfterCall(result)
                }
            }
        case Detail.Sections.similarMovies.rawValue:
            NetworkManager.shared.recommendCallRequest(id: 683722, page: 1) { result in
                DispatchQueue.main.async {
                    self.setTableViewAfterCall(result)
                }
            }
        default:
            print("error")
        }
        
        return cell
    }
    
    private func setTableViewAfterCall(_ result: Result<Search, Error>) {
        switch result {
        case .success(let value):
            print("SUCCESS")
            
        case .failure(let error):
            print("Failed")
            print(error)
        }
    }
}
