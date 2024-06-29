//
//  MyPageViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Page"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
