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
 - 검색리스트
 - 위시리스트
 - 봤어요리스트
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
    
    // 무비 위시리스트
    var movieWishList: [String] {
        get {
            return UserDefaults.standard.array(forKey: "movieWishList") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "movieWishList")
        }
    }
    
    // 무비 봤어요 딕셔너리 = id : Bool 형태로 저장, Int -> String String -> Int
    var movieSawDictionary: [Int: Bool] {
        get {
            guard let data = UserDefaults.standard.object(forKey: "movieSawDictionary") as? [String: Bool] else {
                return [:]
            }
            var convertedData: [Int: Bool] = [:]

            data.forEach { key, value in
                if let intKey = Int(key) {
                    convertedData[intKey] = value
                }
            }
            return convertedData
        }
        set {
            var data: [String: Bool] = [:]

            newValue.forEach { key, value in
                data[String(key)] = value
            }
            
            UserDefaults.standard.set(data, forKey: "movieSawDictionary")
        }
    }
}
