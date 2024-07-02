//
//  MainViewController.swift
//  Reminder
//
//  Created by 황민채 on 7/2/24.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {
    
    let mainView = MainView()
   
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        let edit = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(editButtonClicked))
        
        navigationItem.rightBarButtonItem = edit
    }
    
    @objc private func editButtonClicked() {
        print("편집")
    }
}
