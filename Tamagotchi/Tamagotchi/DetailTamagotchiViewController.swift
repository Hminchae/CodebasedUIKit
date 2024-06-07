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
        v.font = .systemFont(ofSize: 13)
        v.textColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
        v.textAlignment = .center
        v.lineBreakMode = .byWordWrapping
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        bubbleLabel.text = tamagotchiSay.sentence.randomElement()
        configureNavigationItem()
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(bubbleView)
        
        configureBubbleUI()
        configureLayout()
    }
    
    func configureLayout() {
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(80)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(300)
        }
    }
    
    func configureBubbleUI() {
        bubbleView.addSubview(bubbleImageView)
        bubbleView.addSubview(bubbleLabel)
        
        bubbleImageView.snp.makeConstraints { make in
            make.edges.equalTo(bubbleView)
        }
        
        bubbleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(bubbleImageView.snp.verticalEdges).inset(10)
            make.horizontalEdges.equalTo(bubbleImageView.snp.horizontalEdges).inset(10)
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
    }
    
    @objc func profileButtonClicked() {
        let vc = SettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


