//
//  AnimationViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/15/24.
//

import UIKit

class AnimationViewController: UIViewController {
    
    // MARK: UI 프로퍼티 생성
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 없으신가요? 회원가입"
        label.textColor = .systemBlue
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 1️⃣ 초기 상태 설정
        logoImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        loginButton.alpha = 0
        signUpLabel.alpha = 0
        
        animationImageView()// ⬅️ 점점 안 투명
    }
    
    func animationImageView() {
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8) {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.logoImageView.transform = CGAffineTransform(rotationAngle: 500)
        } completion: { _ in
            self.animationEmailTextFieldLabel()
        }
    }
    
    func animationEmailTextFieldLabel() {
        UIView.animate(withDuration: 1) {
            self.emailTextField.alpha = 1 //
        } completion: { _ in
            self.animationPasswordTextFieldLabel()
        }
    }
    
    func animationPasswordTextFieldLabel() {
        UIView.animate(withDuration: 1) {
            self.passwordTextField.alpha = 1 //
        } completion: { _ in
            self.animationLoginButton()
        }
    }
    
    
    func animationLoginButton() {
        UIView.animate(withDuration: 1) {
            self.loginButton.alpha = 1 //
        } completion: { _ in
            self.animationSignUpLabel()
        }
    }
    
    func animationSignUpLabel() {
        UIView.animate(withDuration: 1) {
            self.signUpLabel.alpha = 1 //
        } completion: { _ in
            
        }
    }
    
    
    // MARK: 매서드
    private func setupViews() {
        view.backgroundColor = .white
        
        [logoImageView, emailTextField, passwordTextField, loginButton, signUpLabel].forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.height.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
