//
//  MainTabBarViewController.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: LookUpLottoViewController())
        let vc2 = UINavigationController(rootViewController: MyNewLottoViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "1.magnifyingglass")
        vc2.tabBarItem.image = UIImage(systemName: "teddybear")
        
        vc1.title = "로또 번호 조회하기"
        vc2.title = "New Lotto"
        
        tabBar.tintColor = .label
        tabBar.barTintColor = .lightGray
        
        setViewControllers([vc1, vc2], animated: true)
    }
}
