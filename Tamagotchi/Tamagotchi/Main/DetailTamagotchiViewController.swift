//
//  DetailTamagotchiViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit
import SnapKit

class DetailTamagotchiViewController: UIViewController {
    
    var tamagotchiInfo: Tamagotchi?
    let user = UserDefaultManager.shared
    
    lazy private var tamagotchiSay = TamagotchiSay(userName: user.captainName)
    
    private let bubbleView: UIView = {
        let v = UIView()
        
        return v
    }()
    
    private let bubbleImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "bubble")
        v.contentMode = .scaleAspectFit
        
        return v
    }()
    
    private var bubbleLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 13)
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.textAlignment = .center
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        
        return v
    }()
    
    lazy private var tamaImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        
        return v
    }()
    
    lazy private var tamaNameLabel: UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.font = .boldSystemFont(ofSize: 13)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.textAlignment = .center
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        v.text = " \((tamagotchiInfo?.name)!) "
        
        return v
    }()
    
    lazy private var levelStack: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 0
        v.distribution = .equalSpacing
        v.alignment = .fill
        v.isLayoutMarginsRelativeArrangement = false
        
        return v
    }()
    
    lazy private var levelLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 13)
        v.text = "LV\(user.tamagotchiLevel)"
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        
        return v
    }()
    
    private var firstDot: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 13)
        v.text = "﹒"
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        
        return v
    }()
    
    lazy private var riceLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 13)
        v.text = "밥알 \(user.rice)개"
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        
        return v
    }()
    
    private let secondDot: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 13)
        v.text = "﹒"
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        
        return v
    }()
    
    lazy private var waterDropLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 13)
        v.text = "물방울 \(user.waterDrop)개"
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        
        return v
    }()
    
    lazy private var riceTextField: UITextField = {
        let v = UITextField()
        v.placeholder = "밥주세용"
        v.borderStyle = .none
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.tintColor = .gray
        v.font = .boldSystemFont(ofSize: 17)
        v.keyboardType = .numberPad
        
        return v
    }()
    
    private var riceButton: UIButton = {
        let v = UIButton()
        v.setTitle("밥먹기", for: .normal)
        v.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        v.tintColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.setTitleColor(#colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1), for: .normal)
        v.clipsToBounds = true
        v.layer.borderWidth = 1.5
        v.layer.borderColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.layer.cornerRadius = 8
        v.titleLabel?.font = .boldSystemFont(ofSize: 15)
        v.addTarget(self, action: #selector(riceButtonClicked), for: .touchUpInside)
        return v
    }()
    
    lazy private var waterTextField: UITextField = {
        let v = UITextField()
        v.placeholder = "물주세용"
        v.borderStyle = .none
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.tintColor = .gray
        v.font = .boldSystemFont(ofSize: 17)
        v.keyboardType = .numberPad
        
        return v
    }()
    
    private var waterDropButton: UIButton = {
        let v = UIButton()
        v.setTitle("물먹기", for: .normal)
        v.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        v.tintColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.setTitleColor(#colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1), for: .normal)
        v.clipsToBounds = true
        v.layer.borderWidth = 1.5
        v.layer.borderColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.layer.cornerRadius = 8
        v.titleLabel?.font = .boldSystemFont(ofSize: 15)
        v.addTarget(self, action: #selector(waterDropButtonClicked), for: .touchUpInside)
        
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        bubbleLabel.text = tamagotchiSay.sentence.randomElement()
        updateTamaImage()
        
        setUpUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBottomBorderToTextField(textField: riceTextField)
        addBottomBorderToTextField(textField: waterTextField)
    }
    
    private func addBottomBorderToTextField(textField: UITextField) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1).cgColor
        textField.layer.addSublayer(border)
    }
    
    func setUpUI() {
        view.addSubview(bubbleView)
        view.addSubview(tamaImageView)
        view.addSubview(tamaNameLabel)
        view.addSubview(levelStack)
        view.addSubview(riceTextField)
        view.addSubview(riceButton)
        view.addSubview(waterTextField)
        view.addSubview(waterDropButton)
        
        configureNavigationItem()
        configureBubbleUI()
        configureLevelStackUI()
        configureLayout()
    }
    
    func configureLayout() {
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(150)
        }
        
        tamaImageView.snp.makeConstraints { make in
            make.top.equalTo(bubbleView.snp.bottom).offset(5)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        tamaNameLabel.snp.makeConstraints { make in
            make.top.equalTo(tamaImageView.snp.bottom).offset(5)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(25)
        }
        
        levelStack.snp.makeConstraints { make in
            make.top.equalTo(tamaNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(190)
            make.height.equalTo(20)
        }
        
        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(levelStack.snp.bottom).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.centerX.equalToSuperview().offset(-(100 / 2 + 10 / 2))
        }
        
        riceButton.snp.makeConstraints { make in
            make.top.equalTo(levelStack.snp.bottom).offset(40)
            make.leading.equalTo(riceTextField.snp.trailing).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.centerX.equalToSuperview().offset(200 / 2 + 10 / 2)
        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(20)
            make.leading.equalTo(riceTextField.snp.leading)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        waterDropButton.snp.makeConstraints { make in
            make.top.equalTo(riceButton.snp.bottom).offset(20)
            make.leading.equalTo(waterTextField.snp.trailing).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
    
    func configureLevelStackUI() {
        print(#function)
        levelStack.addArrangedSubview(levelLabel)
        levelStack.addArrangedSubview(firstDot)
        levelStack.addArrangedSubview(riceLabel)
        levelStack.addArrangedSubview(secondDot)
        levelStack.addArrangedSubview(waterDropLabel)
        
        levelLabel.sizeToFit()
        firstDot.sizeToFit()
        riceLabel.sizeToFit()
        secondDot.sizeToFit()
        waterDropLabel.sizeToFit()
    }
    
    func configureBubbleUI() {
        bubbleView.addSubview(bubbleImageView)
        bubbleView.addSubview(bubbleLabel)
        
        bubbleImageView.snp.makeConstraints { make in
            make.edges.equalTo(bubbleView)
        }
        
        bubbleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(bubbleImageView.snp.verticalEdges).inset(15)
            make.centerX.equalTo(bubbleView.snp.centerX)
            make.width.equalTo(200)
        }
    }
    
    func configureNavigationItem() {
        let profile = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonClicked))
        
        profile.tintColor = #colorLiteral(red: 0.3113029599, green: 0.4182519913, blue: 0.4663134813, alpha: 1)
        navigationItem.title = "\(user.captainName)님의 다마고치"
        navigationItem.rightBarButtonItem = profile
        navigationItem.backButtonTitle = ""
        
    }
    
    @objc func profileButtonClicked() {
        let vc = SettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTamaImage() {
        var imageName: String
        
        switch user.tamagotchiType {
        case 1:
            imageName = "1-\(user.tamagotchiLevel)"
        case 2:
            imageName = "2-\(user.tamagotchiLevel)"
        case 3:
            imageName = "3-\(user.tamagotchiLevel)"
        default:
            imageName = "1-1"
        }
        
        tamaImageView.image = UIImage(named: imageName)
    }

    // TODO: 텍스트필드 49까지만, 넘으면 얼럿 띄우기
    @objc func riceButtonClicked() {
        if let text = riceTextField.text, !text.isEmpty {
            if let riceToAdd = Int(text) {
                user.rice += riceToAdd
            }
        } else {
            user.rice += 1
        }
        bubbleLabel.text = tamagotchiSay.sentence.randomElement()
        levelLabel.text = "LV\(user.tamagotchiLevel)"
        riceLabel.text = "밥알 \(user.rice)개"
        
        updateTamaImage()
    }
    
    @objc func waterDropButtonClicked() {
        if let text = waterTextField.text, !text.isEmpty {
            if let waterToAdd = Int(text) {
                user.waterDrop += waterToAdd
            }
        } else {
            user.waterDrop += 1
            print(user.tamagotchiLevel)
        }
        bubbleLabel.text = tamagotchiSay.sentence.randomElement()
        levelLabel.text = "LV\(user.tamagotchiLevel)"
        waterDropLabel.text = "밥알 \(user.waterDrop)개"
        
        updateTamaImage()
    }
}


