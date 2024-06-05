//
//  MarketViewController.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit

class MarketViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        
        print(#function, "1111")
        callRequest()
        print(#function, "2222")
    }
    func configureTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    func callRequest() {
        print(#function, "3333")
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let value):
                print(value[0])
            case .failure(let error):
                print(error)
            }
        }
        print(#function, "4444")
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

struct Market: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
}
