//
//  UserDefaultManager.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import Foundation

/*
 ✅ 유저가 가져야할 것
 - 닉네임
 -
 */

final class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private init() { }
    
    var nickName: String {
        get {
            return UserDefaults.standard.string(forKey: "nickName") ?? "사용자"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "nickName")
        }
    }
    
    var mySearchList: [String] {
        get {
            return UserDefaults.standard.array(forKey: "mySearchList") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mySearchList")
        }
    }
}
