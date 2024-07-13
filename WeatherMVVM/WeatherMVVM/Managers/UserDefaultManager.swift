//
//  UserDefaultManager.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/13/24.
//

import Foundation

/*
 ✅ 유저가 가져야할 것
 - 검색내역
 */

final class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private init() { }
    
    
    var myWeatherList: [String] {
        get {
            return UserDefaults.standard.array(forKey: "myWeatherList") as? [String] ?? []
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "myWeatherList")
        }
    }
}
