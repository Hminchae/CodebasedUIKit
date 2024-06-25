//
//  BaseViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Base", #function)
        view.backgroundColor = .white // 공통적인 옵션들을 몰아서 정의할 수 있음
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        print("Base", #function)
    }
    
    func configureLayout() {
        print("Base", #function)
    }
    
    func configureView() {
        print("Base", #function)
    }
}
