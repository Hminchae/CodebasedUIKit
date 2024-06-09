//
//  SettingNameViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/9/24.
//

import UIKit
import SnapKit

class SettingNameViewController: UIViewController {
    
    let user = UserDefaultManager.shared
    
    lazy private var captainNameTextField: UITextField = {
        let v = UITextField()
        v.placeholder = "대장님 이름을 입력해주세용"
        v.borderStyle = .none
        v.textAlignment = .left
        v.textColor = .fontColor
        v.tintColor = .gray
        v.font = .boldSystemFont(ofSize: 15)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        configureNavigationItem()
        configureUI()
        
        captainNameTextField.text = user.captainName
        
        self.hideKeyboardWhenTappedBackground()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBottomBorderToTextField(captainNameTextField)
    }
    
    func configureUI() {
        view.addSubview(captainNameTextField)
        
        captainNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges).inset(20)
            make.height.equalTo(50)
        }
    }
    
    func configureNavigationItem() {
        
        title = "대장님 이름 정하기"
        
        let saveButton = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonClicked))
        
        saveButton.tintColor = .black
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        if let text = captainNameTextField.text, !text.isEmpty {
            if text.count > 1 && text.count < 7 {
                user.captainName = text
        
                let alert = UIAlertController(
                    title: "대장님 이름이 변경되었습니다!",
                    message: nil,
                    preferredStyle: .alert)

                let confirm = UIAlertAction(
                    title: "알았어 :D",
                    style: .default)
                
                alert.addAction(confirm)
                present(alert, animated: true)
            } else {
                let alert = UIAlertController(
                    title: "대장님 이름을 다시 적어주세용!",
                    message: "2글자 이상 6글자 이하까지만 가능해용!",
                    preferredStyle: .alert)

                let confirm = UIAlertAction(
                    title: "알았어 :D",
                    style: .default) { action in
                        self.captainNameTextField.text = ""
                }
                
                alert.addAction(confirm)
                present(alert, animated: true)
            }
        }
    }
    
    private func addBottomBorderToTextField(_ textField: UITextField) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 1)
        border.backgroundColor = UIColor.fontColor?.cgColor
        textField.layer.addSublayer(border)
    }
}

// 빈 화면 탭 시 키보드 내리기
extension SettingNameViewController {
    func hideKeyboardWhenTappedBackground() {
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapEvent.cancelsTouchesInView = false
        view.addGestureRecognizer(tapEvent)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
