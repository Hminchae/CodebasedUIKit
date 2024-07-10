//
//  SceneDelegate.swift
//  iCrypto
//
//  Created by 황민채 on 7/10/24.
//

import UIKit

import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = UINavigationController(rootViewController: HomeController())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        SDImageCache.shared.config.maxDiskSize = 1000000 * 2 // 캐시 리밋 설정
        
    }

}

