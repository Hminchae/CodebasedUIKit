//
//  SceneDelegate.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/17/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // 1. Badge 제거 : 0이면 사라짐
        UIApplication.shared.applicationIconBadgeNumber = 1
        // 2. 사용자에게 전달되어 있는 알람 제거
        //  -> 알람 전체 삭제
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        //  -> 특정 알람 삭제
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["thanky"])
        //  -> 앞으로 전달될 알람 삭제
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // 3. 사용자에게 앞으로 전달될 알람 제거
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

