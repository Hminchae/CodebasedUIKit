//
//  SettingItem.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/9/24.
//

import Foundation

struct SettingItem {
    let settingIcon: String
    let settingName: String
}

struct SettingSet {
    static let tamaSettingSet: [SettingItem] = [
    SettingItem(settingIcon: "pencil", 
                settingName: "내 이름 설정하기"),
    SettingItem(settingIcon: "moon.fill", 
                settingName: "다마고치 변경하기"),
    SettingItem(settingIcon: "arrow.clockwise",
                settingName: "데이터 초기화")
    ]
}
