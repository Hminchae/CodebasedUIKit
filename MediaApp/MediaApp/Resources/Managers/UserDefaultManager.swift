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
    
    // 무비 위시리스트
    var movieWishList: [String] {
        get {
            return UserDefaults.standard.array(forKey: "movieWishList") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "movieWishList")
        }
    }
    
    // 무비 봤어요 딕셔너리 = id : Bool 형태로 저장
    var movieSawDictionary: [String: Bool] {
        get {
            return UserDefaults.standard.dictionary(forKey: "movieSawDictionary") as? [String: Bool] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "movieSawDictionary")
        }
    }
}
