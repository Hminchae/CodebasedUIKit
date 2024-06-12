//
//  ViewController.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

import Alamofire
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
    
    private func configureHierachy() {
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
    }
    
    private func configureLayout() {
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
        
        numberTextField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        numberTextField.layer.cornerRadius = 10
        numberTextField.placeholder = "회차를 입력하세요"
        
        checkButton.backgroundColor = .white
        checkButton.setTitle("로또 당첨 번호 확인", for: .normal)
        checkButton.setTitleColor(.black, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        checkButton.layer.cornerRadius = 10
        checkButton.layer.borderColor = UIColor.black.cgColor
        checkButton.layer.borderWidth = 2
        
        resultLabel.backgroundColor = .black.withAlphaComponent(0.5)
        resultLabel.textColor = .white
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.clipsToBounds = true
        resultLabel.layer.cornerRadius = 10
    }
    
    // 💡 Swift.DecodingError.keyNotFound
    // 1️⃣ URL 확인
    // 2️⃣ respnseString 으로 확인
    // 3️⃣ nil
    
    @objc func checkButtonClicked() {
        print(#function)
        let url = "\(APIURL.lottoURL)\(numberTextField.text!)"

        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                
                self.resultLabel.text = "\(value.drwNoDate)\n1등 당첨금액: \(value.totSellamnt.formatted())"
            case .failure(let error):
                print(error)
                self.resultLabel.text = "올바른 값을 입력해주세요."
            }
        }
    }
}

