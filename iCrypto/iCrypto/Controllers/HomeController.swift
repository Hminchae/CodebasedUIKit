//
//  ViewController.swift
//  iCrypto
//
//  Created by 황민채 on 7/10/24.
//

import UIKit

class HomeController: UIViewController {

    // MARK: - Variables
    private let coins: [Coin] = Coin.getMockArray()
    
    // MARK: - UI Components
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        
        return tableView
    }()

    // MARK: - UI Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "iCrypto"
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Coin Cell 등록 오류")
        }
        
        let coin = self.coins[indexPath.row]
        cell.configure(with: coin)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = self.coins[indexPath.row]
        let vc = ViewCryptoController(coin)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}















// MARK: - Variables


// MARK: - UI Components


// MARK: - UI Lifecycle


// MARK: - UI Setup
