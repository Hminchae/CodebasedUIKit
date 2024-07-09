//
//  NumberViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by jack on 7/9/24.
//

import UIKit
import SnapKit

class NumberViewController: UIViewController {

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()

    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₩0"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let convertedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
 
    private let exchangeRate = 1300.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        configureActions()
    }

    // MARK: - configure Methods
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
        view.addSubview(convertedAmountLabel)
    }

    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }

        convertedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(formattedAmountLabel.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }

    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }
 
    @objc private func amountChanged() {
        print(#function)
        
        // 1.
        guard let text = amountTextField.text else { return }
        
        // 2.
        if text.isEmpty {
            formattedAmountLabel.text = "값을 입력해주세요"
            convertedAmountLabel.text = "값을 입력해주세요"
        }
        
        // 3.
        guard let num = Int(text) else {
            formattedAmountLabel.text = "숫자만 입력해주세요"
            convertedAmountLabel.text = "숫자만 입력해주세요"
            return
        }
        
        // 4.
        if num > 0, num <= 10000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            
            let wonResult = format.string(from: num as NSNumber)!
            formattedAmountLabel.text = "₩" + wonResult
            
            let converted = Double(num) / exchangeRate
            
            let convertedFormat = NumberFormatter()
            convertedFormat.numberStyle = .currency
            convertedFormat.currencyCode = "USD"
            
            let convertedResult = convertedFormat.string(from: converted as NSNumber)
            convertedAmountLabel.text = convertedResult
            
        } else {
            formattedAmountLabel.text = "1,000만원 이하를 입력해주세요"
            convertedAmountLabel.text = "1,000만원 이하를 입력해주세요"
        }
    }
}
