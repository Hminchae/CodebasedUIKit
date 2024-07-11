//
//  AppDelegate.swift
//  SeSAC5MVVMBasic
//
//  Created by jack on 7/9/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UILabel.appearance().font = .boldSystemFont(ofSize: 20)
        UILabel.appearance().textColor = .blue
        UILabel.appearance().backgroundColor = .black
        
        UIButton.appearance().backgroundColor = .red
        
        UITextField.appearance().font = .boldSystemFont(ofSize: 20)
        UITextField.appearance().textColor = .purple
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .red
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.yellow
        ]
        
        navigationBarAppearance.largeTitleTextAttributes
        
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        let navigationBarAppearance2 = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance2.backgroundColor = .blue
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance2

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .blue
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .blue
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.orange]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

