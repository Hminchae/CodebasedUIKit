//
//  UserDefaultManager.swift
//  aeWeather
//
//  Created by 황민채 on 6/23/24.
//

import Foundation

/*
 ✅ 유저가 가져야할 것
 유저 이름
 */

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private init() { }
    
    var userName : String {
        get {
            return UserDefaults.standard.string(forKey: "userName") ?? "친구"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }
}
