//
//  ViewController.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

class LookUpLottoViewController: UIViewController, UITextFieldDelegate {
    
    let lottoRoundTextField = UITextField()
    
    // 당첨번호 안내 label
    let infoLabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // ex) 2020-08-20 추첨
    let infoOfRoundLabel = UILabel()
    
    let separaterView = UIView()
    
    let roundStack = UIStackView()
    // 회차
    var keyRound: Int = 986
    // ~ 회차
    let roundLabel = UILabel()
    
    // 당첨결과
    let resultLabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        
        return label
    }()
    
    let ballStack = UIStackView()
    
    var stackItem1 = UILabel()
    var stackItem2 = UILabel()
    var stackItem3 = UILabel()
    var stackItem4 = UILabel()
    var stackItem5 = UILabel()
    var stackItem6 = UILabel()
    var stackItem7 = UILabel()
    
    var stackItemPlus = UILabel()
    
    let pickerView = UIPickerView()
    
    let numbers = Array(1...986).reversed() as [Int]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        
        lottoRoundTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        lottoRoundTextField.delegate = self

        configureLayout()
        configureUI()
        configureNetwork()
        configureRoundStack()
        configureBallStack()
    }
    
    func configureHierachy() {
        view.addSubview(lottoRoundTextField)
        view.addSubview(infoLabel)
        view.addSubview(infoOfRoundLabel)
        view.addSubview(separaterView)
        view.addSubview(roundStack)
        view.addSubview(ballStack)
    }
    
    func configureRoundStack() {
        roundStack.translatesAutoresizingMaskIntoConstraints = false
        roundStack.axis = .horizontal
        roundStack.spacing = 0
        roundStack.distribution = .equalCentering
        roundStack.isLayoutMarginsRelativeArrangement = true
        
        roundStack.addArrangedSubview(roundLabel)
        roundStack.addArrangedSubview(resultLabel)
    }
    
    func configureBallStack() {
        ballStack.translatesAutoresizingMaskIntoConstraints = false
        ballStack.axis = .horizontal
        ballStack.spacing = 10
        ballStack.distribution = .fillEqually
        ballStack.isLayoutMarginsRelativeArrangement = true
        
        ballStack.addArrangedSubview(stackItem1)
        ballStack.addArrangedSubview(stackItem2)
        ballStack.addArrangedSubview(stackItem3)
        ballStack.addArrangedSubview(stackItem4)
        ballStack.addArrangedSubview(stackItem5)
        ballStack.addArrangedSubview(stackItem6)
        ballStack.addArrangedSubview(stackItemPlus)
        ballStack.addArrangedSubview(stackItem7)
    }
    
    func configureLayout() {
        lottoRoundTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(45)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoRoundTextField.snp_bottomMargin).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        infoOfRoundLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoRoundTextField.snp_bottomMargin).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        separaterView.snp.makeConstraints { make in
            make.top.equalTo(infoOfRoundLabel.snp_bottomMargin).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(0.5)
        }
        
        roundStack.snp.makeConstraints { make in
            make.top.equalTo(separaterView.snp_bottomMargin).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(120)
        }
        
        ballStack.snp.makeConstraints { make in
            make.top.equalTo(roundStack.snp_bottomMargin).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(33)
        }
    }
    
    func configureUI() {
        lottoRoundTextField.borderStyle = .roundedRect
        lottoRoundTextField.layer.cornerRadius = 10
        lottoRoundTextField.tintColor = .gray
        lottoRoundTextField.textAlignment = .center
        
        infoOfRoundLabel.font = .systemFont(ofSize: 13)
        infoOfRoundLabel.textColor = .darkGray
        
        separaterView.backgroundColor = .lightGray
        
        roundLabel.text = "\(keyRound)회"
        roundLabel.font = .boldSystemFont(ofSize: 20)
        roundLabel.textColor = UIColor.random()
    }
    
    func configureNetwork() {
        
        let url = "\(APIURL.lottoURL)\(keyRound)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value.lottoDate)
                self.infoOfRoundLabel.text = "\(value.lottoDate) 추첨"
                self.stackItem1.setBallUI(value.num1)
                self.stackItem2.setBallUI(value.num2)
                self.stackItem3.setBallUI(value.num3)
                self.stackItem4.setBallUI(value.num4)
                self.stackItem5.setBallUI(value.num5)
                self.stackItem6.setBallUI(value.num6)
                self.stackItem7.setBallUI(value.num7)
                self.stackItemPlus.setPlusLabelUI()
            case .failure(let error):
                print(error)
            }
        }
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
        keyRound = numbers[row]
        roundLabel.text = "\(numbers[row])회"
        lottoRoundTextField.text = "\(numbers[row])회차"
        configureNetwork()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])회차"
    }
}

struct Lotto: Decodable {
    let returnValue : String
    let lottoDate : String
    let num1 : Int
    let num2 : Int
    let num3 : Int
    let num4 : Int
    let num5 : Int
    let num6 : Int
    let num7 : Int
    let prizeMoney : Int
    let lottoRound : Int
    
    enum CodingKeys: String, CodingKey {
        case returnValue = "returnValue"
        case lottoDate = "drwNoDate"
        case num1 = "drwtNo1"
        case num2 = "drwtNo2"
        case num3 = "drwtNo3"
        case num4 = "drwtNo4"
        case num5 = "drwtNo5"
        case num6 = "drwtNo6"
        case num7 = "bnusNo"
        case prizeMoney = "firstWinamnt"
        case lottoRound = "drwNo"
    }
}
