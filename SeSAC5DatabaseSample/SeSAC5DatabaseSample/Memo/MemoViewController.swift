//
//  MemoViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit
import SnapKit
 
class MemoViewController: BaseViewController {

    let memoTextField = UITextField()
     
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         
    }
     
    override func configureHierarchy() {
        view.addSubview(memoTextField)
    }
 
    override func configureView() {
        super.configureView()
        memoTextField.placeholder = "한 줄 메모를 입력해보세요"
        memoTextField.keyboardType = .default
    }
    
    override func configureConstraints() {
        memoTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
}
