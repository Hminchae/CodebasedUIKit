//
//  SampleViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/11/24.
//

import UIKit

class SampleViewController: UIViewController {
    
    private lazy var idTextField: UITextField = { (ph) -> UITextField in // 매개변수가 없고 반환값이 UITextField
        let textField = UITextField()
        textField.placeholder = ph
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }("아이이이디ㅣ디디~~")
    
    func makeIdTextField(ph: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = ph
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let validationLabel: UILabel = {
        let label = UILabel()
        label.text = "유효성 레이블"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()

    func text(a: Int, thanky: (String, Int) -> Void) {
        thanky("땡키", 8)
        
        func sample(ph: String, num: Int) { // 반환값이 없으면 생략이 가능해서..
            let b = 2
            idTextField.text = "\(ph)\(b + num)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        text(a: 8) { ph, number in
            let b = number
            idTextField.text = "\(ph)~~~\(number)"
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(validationLabel)
        view.addSubview(loginButton)
    }

    private func configureConstraints() {
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(idTextField)
        }

        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(idTextField)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.left.right.equalTo(idTextField)
            make.height.equalTo(50)
        }
    }
}
