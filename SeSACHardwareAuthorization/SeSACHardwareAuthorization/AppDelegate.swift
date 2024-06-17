//
//  AppDelegate.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/17/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ✏️ 알림권한 설정
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            print(success, error)
        }
        
        UNUserNotificationCenter.current().delegate = self
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


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 포그라운드에서 알람을 받고 싶을 때(willPresent)
    // ex. 특정화면에서는 안 받고 싶어!
    // ex. 카카오톡.. Jack:Den
    // ex. 친구랑 1:1 채팅할 경우. 다른 단톡방이나 다른 갠톡방 푸시만 오는 것 처럼, 특정 화면/ 특정 조건에 대해서 포그라운드 알림을 받게 설정하는 것도 가능
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .badge, .list, .sound])
    }
    
    // 클릭되었는지 확인할 대 didReceive(푸시랑 로컬이랑 따로있음)
    // 언제 쓰일까요?
    // 화면 이동.. 카카오톡 채팅 화면 띄워줄때
    // 상대방이 날 차단 했다면?
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("클릭")
    }
}
