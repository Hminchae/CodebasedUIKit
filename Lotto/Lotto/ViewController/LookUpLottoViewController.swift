//
//  ViewController.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

import SnapKit

class LookUpLottoViewController: UIViewController, UITextFieldDelegate {
    
    let lottoRoundTextField = UITextField()
    
    let infoLabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "당첨번호 안내"
        
        return label
    }()
    
    let infoOfRoundLabel = {
        let label = UILabel()
        label.textColor = .lightGray
    }
    
    let separaterView = UIView()
    
    // ~ 회차
    let winningLabel = UILabel()
    // 당첨결과
    let resultLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor.random()
        return label
    }()
    
    let stackView = UIStackView()
    
    let stackItem1 = UILabel()
    let stackItem2 = UILabel()
    let stackItem3 = UILabel()
    let stackItem4 = UILabel()
    let stackItem5 = UILabel()
    let stackItem6 = UILabel()
    let stackItem7 = UILabel()
    let stackItemPlus = UILabel()
    
    let pickerView = UIPickerView()
    
    let numbers = Array(1...986).reversed() as [Int]
    
    let keyRound: Int = 986
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        
        lottoRoundTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        lottoRoundTextField.delegate = self

        configureLayout()
        configureUI()
    }
    
    func configureHierachy() {
        view.addSubview(lottoRoundTextField)
    }
    
    func configureLayout() {
        lottoRoundTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
    }
    
    func configureUI() {
        lottoRoundTextField.borderStyle = .roundedRect
        lottoRoundTextField.layer.cornerRadius = 10
        lottoRoundTextField.tintColor = .gray
    }
}

extension LookUpLottoViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        winningLabel.text = "\(numbers[row])회차"
        lottoRoundTextField.text = "\(numbers[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])회차"
    }
}
