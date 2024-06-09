//
//  TamagotchiStartViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit
import SnapKit

class TamagotchiStartViewController: UIViewController {
    
    var tamagotchiInfo: Tamagotchi?
    let user = UserDefaultManager.shared
    
    let startView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.backgroundColor = .bgColor
        return v
    }()
    
    private let label: UILabel = {
        let v = UILabel()
        v.textColor = .fontColor
        v.font = .boldSystemFont(ofSize: 13)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.textAlignment = .center
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        
        return v
    }()
    
    private let imageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        
        return v
    }()
    
    private let separator: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        
        return v
    }()
    
    private let detailLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = .systemFont(ofSize: 13)
        v.textColor = .fontColor
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
        return v
    }()
    
    private let buttonSeparater: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray.withAlphaComponent(0.8)
        
        return v
    }()
    
    private let cancelButton: UIButton = {
        let v = UIButton()
        v.setTitle("취소", for: .normal)
        v.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        v.setTitleColor(UIColor.fontColor, for: .normal)
        v.backgroundColor = #colorLiteral(red: 0.8921869397, green: 0.930788219, blue: 0.9381119609, alpha: 1)
        v.titleLabel?.font = .systemFont(ofSize: 13)
        
        return v
    }()
    
    lazy private var startButton: UIButton = {
        let v = UIButton()
        let titleStr: String
        titleStr = user.tamaChangedState ? "변경하기" : "시작하기"
        v.setTitle(titleStr, for: .normal)
        v.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        v.setTitleColor(UIColor.fontColor, for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 13)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.addSubview(startView)
        
        configureUIView()
        configureLayout()
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func startButtonClicked() {
        // 설정 -> 변경하기 진입 시
        if user.tamaChangedState {
            user.tamagotchiType = tamagotchiInfo?.serialNum ?? 0
            user.tamaChangedState = false
            dismiss(animated: true)
            navigationController?.popToRootViewController(animated: true)
        // 첫 화면에서 진입 시
        } else {
            user.tamagotchiType = tamagotchiInfo?.serialNum ?? 0
            
            let vc = DetailTamagotchiViewController()
            vc.tamagotchiInfo = tamagotchiInfo
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            
            present(nav, animated: true)
        }
    }
    
    func configureLayout() {
        startView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(startView.snp.width).multipliedBy(1.3)
        }
    }
    
    func configureUIView() {
        startView.addSubview(imageView)
        startView.addSubview(label)
        startView.addSubview(separator)
        startView.addSubview(detailLabel)
        startView.addSubview(buttonSeparater)
        startView.addSubview(cancelButton)
        startView.addSubview(startButton)

        imageView.image = UIImage(named: tamagotchiInfo?.face ?? "")
        label.text = " \((tamagotchiInfo?.name)!)    "
        detailLabel.text = tamagotchiInfo?.description
        
        configureUIViewLayout()
    }
    
    func configureUIViewLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(startView.snp.top).offset(30)
            make.centerX.equalTo(startView.snp.centerX)
            make.width.equalTo(130)
            make.height.equalTo(130)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.equalTo(startView.snp.centerX)
            make.height.equalTo(25)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalTo(startView.snp.centerX)
            make.horizontalEdges.equalTo(startView.snp.horizontalEdges).inset(50)
            make.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.centerX.equalTo(startView.snp.centerX)
            make.horizontalEdges.equalTo(startView.snp.horizontalEdges).inset(50)
        }
        
        buttonSeparater.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(startView.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(buttonSeparater.snp.bottom)
            make.bottom.equalTo(startView.snp.bottom)
            make.leading.equalTo(startView.snp.leading)
            make.width.equalTo(startButton)
            make.height.equalTo(45)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing)
            make.top.equalTo(cancelButton.snp.top)
            make.trailing.equalTo(startView.snp.trailing)
            make.bottom.equalTo(startView.snp.bottom)
        }
    }
}
