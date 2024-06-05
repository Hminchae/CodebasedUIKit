//
//  ViewController.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/5/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let numberTextField = UITextField()
    let checkButton = UIButton()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    func configureHierachy() {
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(checkButton.snp.bottom).offset(20) // inset(-20) 와 같음
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        numberTextField.backgroundColor = .brown
        checkButton.backgroundColor = .magenta
        checkButton.setTitle("로또 당첨 번호 확인", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        resultLabel.backgroundColor = .cyan
    }
    
    @objc func checkButtonClicked() {
        print(#function)
    }
}

