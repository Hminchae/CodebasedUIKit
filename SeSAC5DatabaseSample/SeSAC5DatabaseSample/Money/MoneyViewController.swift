//
//  MoneyViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit
import SnapKit

class MoneyViewController: BaseViewController {

    let moneyTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         
    }
    
    override func configureHierarchy() {
        view.addSubview(moneyTextField)
    }
    
    override func configureView() {
        super.configureView()
        moneyTextField.placeholder = "금액을 입력해보세요"
        moneyTextField.keyboardType = .numberPad
    }
    
    override func configureConstraints() {
        moneyTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
}
