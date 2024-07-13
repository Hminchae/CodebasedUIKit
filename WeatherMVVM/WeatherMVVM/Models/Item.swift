//
//  Item.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/13/24.
//

import Foundation

// 섹션과 아이템 정의
struct Section: Hashable {
    let id: String
}

enum Item: Hashable {
    case banner(BannerItem)
    case hourlyWeather
    case weeklyWeather
    case precipitationMap
    case etcInfo // 바람속도, 구름, 기압, 습도 등
}

struct BannerItem: Hashable {
    let location: String
    let temperature: Int
    let description: String
    let maxTemp: Int
    let minTemp: Int
}
