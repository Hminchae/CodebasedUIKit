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
    
    let startView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        return v
    }()
    
    private let label: UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
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
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
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
        v.setTitleColor(#colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1), for: .normal)
        v.backgroundColor = #colorLiteral(red: 0.8921869397, green: 0.930788219, blue: 0.9381119609, alpha: 1)
        v.titleLabel?.font = .systemFont(ofSize: 13)
        
        return v
    }()
    
    private let startButton: UIButton = {
        let v = UIButton()
        v.setTitle("시작하기", for: .normal)
        v.setTitleColor(#colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1), for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 13)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.addSubview(startView)
        
        configureUIView()
        configureLayout()
        
        print(tamagotchiInfo)
    }
    
    @objc func cancelButtonClicked() {
        cancelButton.backgroundColor = #colorLiteral(red: 0.8921869397, green: 0.930788219, blue: 0.9381119609, alpha: 1)
        dismiss(animated: true)
    }
    
    func configureLayout() {
        startView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(50)
            make.verticalEdges.equalTo(view.snp.verticalEdges).inset(180)
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
        label.text = " \((tamagotchiInfo?.name)!)  "
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
            make.height.equalTo(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing)
            make.top.equalTo(cancelButton.snp.top)
            make.trailing.equalTo(startView.snp.trailing)
            make.bottom.equalTo(startView.snp.bottom)
        }
        
    }
}
