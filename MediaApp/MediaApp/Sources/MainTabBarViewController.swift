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
        let wish = UINavigationController(rootViewController: WishViewController())
        let myPage = UINavigationController(rootViewController: MyPageViewController())
        
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
        myPage.tabBarItem = UITabBarItem(title: "My Page",
                                         image: UIImage(systemName: "person"),
                                         selectedImage: UIImage(systemName: "person.fill"))
        
        tabBar.tintColor = .white
        
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = .bg.withAlphaComponent(0.4)
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
                // set tabbar opacity
                tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        setViewControllers([trend, search, wish, myPage], animated: true)
    }
}
