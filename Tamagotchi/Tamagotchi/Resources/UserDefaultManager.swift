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
 물방울
 레벨 -> 밥알과 물방울로 레벨 계산
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
    
    var tamagotchiLevel: Int {
        let riceScore = self.rice / 5
        let waterDropScore = self.waterDrop / 2
        let totalScore = riceScore + waterDropScore
        
        switch totalScore {
        case 0..<10:
            return 1
        case 10..<20:
            return 1
        case 20..<30:
            return 2
        case 30..<40:
            return 3
        case 40..<50:
            return 4
        case 50..<60:
            return 5
        case 60..<70:
            return 6
        case 70..<80:
            return 7
        case 80..<90:
            return 8
        case 90..<100:
            return 9
        case 10...:
            return 10
        default:
            return 1
        }
    }
    
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
