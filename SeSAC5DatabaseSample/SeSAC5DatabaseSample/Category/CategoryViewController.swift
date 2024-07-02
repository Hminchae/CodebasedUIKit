//
//  CategoryViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit
import SnapKit

class CategoryViewController: BaseViewController {

    let categoryTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func configureHierarchy() {
        view.addSubview(categoryTextField)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
          
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func configureView() {
        super.configureView()
        categoryTextField.placeholder = "카테고리를 입력해보세요"
        categoryTextField.keyboardType = .default
    }
    
    override func configureConstraints() {
        categoryTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }


}

