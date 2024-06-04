//
//  MainTabBarController.swift
//  Thankyflix
//
//  Created by 황민채 on 6/4/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: NewHotViewController())
        let vc3 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc3.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        
        vc1.title = "홈"
        vc2.title = "NEW & HOT"
        vc3.title = "저장된 콘텐츠 목록"
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .lightGray
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}
