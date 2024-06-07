//
//  DetailTamagotchiViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit

class DetailTamagotchiViewController: UIViewController {

    var tamagotchiInfo: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        configureNavigationItem()
    }
    
    func configureNavigationItem() {
        let profile = UIBarButtonItem(
            title: "헤이ㅣㅣ",
            style: .plain,
            target: self,
            action: #selector(profileButtonClicked))
        
        print(tamagotchiInfo)
        navigationItem.title = tamagotchiInfo?.name
        navigationItem.rightBarButtonItem = profile
    }
    
    @objc func profileButtonClicked() {
        let vc = SettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


