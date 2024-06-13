//
//  TabBarController.swift
//  SeSACWeek5Summery
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
        
        let vc1 = NicknameViewController()
        let nickname = UINavigationController(rootViewController: vc1)
        nickname.tabBarItem = UITabBarItem(title: "nickname",
                                           image: UIImage(systemName: "heart"),
                                           tag: 0)
        let vc2 = BirthdayViewController()
        let birthDay = UINavigationController(rootViewController: vc2)
        birthDay.tabBarItem = UITabBarItem(title: "birthDay",
                                           image: UIImage(systemName: "heart"),
                                           tag: 1)
        let vc3 = PhoneViewController()
        let phone = UINavigationController(rootViewController: vc3)
        phone.tabBarItem = UITabBarItem(title: "phone",
                                        image: UIImage(systemName: "person"),
                                        tag: 2)
        
        setViewControllers([nickname, birthDay, phone], animated: true) // 🧐 스토리보드의 세그 연결과 같은 역할
    }
}
