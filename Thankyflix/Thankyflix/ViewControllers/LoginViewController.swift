//
//  LoginViewController.swift
//  Thankyflix
//
//  Created by 황민채 on 6/4/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let largeTitle = {
        let title = UILabel()
        title.text = "THANKYFLX"
        title.textColor = .systemRed
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 50, weight: .black)
        
        return title
    }()
    
    let fieldStackView = UIStackView()
    
    let emailTextField = {
        let textField = UITextField()
        textField.setLoginTextField("이메일 주소 또는 전화번호")
        
        return textField
    }()
    
    let passwordTextField = {
        let textField = UITextField()
        textField.setLoginTextField("비밀번호")
        
        return textField
    }()
    
    let nickNameTextField = {
        let textField = UITextField()
        textField.setLoginTextField("닉네임")
        
        return textField
    }()
    
    let locationTextField = {
        let textField = UITextField()
        textField.setLoginTextField("위치")
        
        return textField
    }()
    
    let recomendCodeTextField = {
        let textField = UITextField()
        textField.setLoginTextField("추천 코드 입력")
        
        return textField
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let addInfoLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let infoToggle = {
        let switchButton = UISwitch()
        switchButton.onTintColor = .red
        return switchButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureHierachy()
        configureStackView()
        configureLayout()
    }
    
    func configureHierachy() {
        view.addSubview(largeTitle)
        view.addSubview(fieldStackView)
        view.addSubview(signUpButton)
        view.addSubview(addInfoLabel)
        view.addSubview(infoToggle)
    }
    
    func configureLayout() {
        largeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(30)
        }
        
        fieldStackView.snp.makeConstraints { make in
            make.top.equalTo(largeTitle.snp.bottom).offset(150)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(250)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(50)
        }
        
        addInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.height.equalTo(30)
        }
        
        infoToggle.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
            make.trailing.equalTo(-20)
            make.height.equalTo(30)
        }
    }
    
    func configureStackView() {
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.axis = .vertical
        fieldStackView.spacing = 15
        fieldStackView.distribution = .fillEqually
        fieldStackView.alignment = .fill
        fieldStackView.isLayoutMarginsRelativeArrangement = true
        
        fieldStackView.addArrangedSubview(emailTextField)
        fieldStackView.addArrangedSubview(passwordTextField)
        fieldStackView.addArrangedSubview(nickNameTextField)
        fieldStackView.addArrangedSubview(locationTextField)
        fieldStackView.addArrangedSubview(recomendCodeTextField)
    }
}
