//
//  UserDefaultManager.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/8/24.
//

import Foundation

/*
 ✅ 유저가 가져야할 것
 대장님 이름
 밥알
 물방울 -> 밥알과 물방울로 레벨 계산
 다마고치 종류 -> 다마고찌 종류가 미설정이면 초기설정 X
*/

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    var captainName : String {
        get {
            return UserDefaults.standard.string(forKey: "captainName") ?? "대장"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "captainName")
        }
    }
    
    var rice : Int {
        get {
            return UserDefaults.standard.integer(forKey: "rice") 
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "rice")
        }
    }
    
    var waterDrop : Int {
        get {
            return UserDefaults.standard.integer(forKey: "waterDrop")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "waterDrop")
        }
    }
    
    // 유저디폴트로 저장프로퍼티 가능?
    var tamagotchiType : Int {
        get {
            return UserDefaults.standard.integer(forKey: "tamagotchiType")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "tamagotchiType")
        }
    }
    
    private init() { }
}
