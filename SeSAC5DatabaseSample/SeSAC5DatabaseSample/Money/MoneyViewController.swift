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
    
    // viewDidLoad 보다 더 빠르게 실행이 됨
    // - 함수를 호출했기 때문
    var nickname: ((String) -> Void)?
    
    var age: Int?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        nickname?(moneyTextField.text ?? "값 없음")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("money",#function, age)
    }
    
    // 1️⃣ 텍스트 필드에 입력된 값을: 어떤 데이터를
    // 2️⃣ 화면이 사라질 때 전달: 어떤 시점에 전달하고
    // 3️⃣ 전달된 값은 added 버튼에 표시: 그 데이터는 어디다 표현?
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
