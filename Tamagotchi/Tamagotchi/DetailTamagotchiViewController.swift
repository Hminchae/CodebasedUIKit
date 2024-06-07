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
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonClicked))
        
        profile.tintColor = #colorLiteral(red: 0.3113029599, green: 0.4182519913, blue: 0.4663134813, alpha: 1)
        print(tamagotchiInfo)
        navigationItem.title = tamagotchiInfo?.name
        navigationItem.rightBarButtonItem = profile
    }
    
    @objc func profileButtonClicked() {
        let vc = SettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


