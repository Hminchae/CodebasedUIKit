//
//  MainTabBarViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .bg
        
        let trend = UINavigationController(rootViewController: TrendViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let wish = UINavigationController(rootViewController: SearchViewController())
        let community = UINavigationController(rootViewController: SearchViewController())
        let myPage = UINavigationController(rootViewController: SearchViewController())
        
        // 탭 바 아이템 설정
        trend.tabBarItem = UITabBarItem(title: "Trend",
                                        image: UIImage(systemName: "movieclapper"),
                                        selectedImage: UIImage(systemName: "movieclapper.fill"))
        search.tabBarItem = UITabBarItem(title: "Search",
                                         image: UIImage(systemName: "magnifyingglass"),
                                         selectedImage: UIImage(systemName: "magnifyingglass.fill"))
        wish.tabBarItem = UITabBarItem(title: "Wishlist",
                                       image: UIImage(systemName: "popcorn"),
                                       selectedImage: UIImage(systemName: "popcorn.fill"))
        community.tabBarItem = UITabBarItem(title: "Community",
                                            image: UIImage(systemName: "person.2"),
                                            selectedImage: UIImage(systemName: "person.2.fill"))
        myPage.tabBarItem = UITabBarItem(title: "My Page",
                                         image: UIImage(systemName: "person"),
                                         selectedImage: UIImage(systemName: "person.fill"))
        
        tabBar.tintColor = .white
        
        setViewControllers([trend, search, wish, community, myPage], animated: true)
    }
}
