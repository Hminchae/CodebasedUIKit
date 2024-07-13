//
//  WEFont.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/13/24.
//

import UIKit

enum WEFont {
    static var r10: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular)
    
    static var r12: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular) // 각 섹션 헤더
    static var m12: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    static var b12: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)
    
    static var r13: UIFont = UIFont.systemFont(ofSize: 13, weight: .regular) // 본문 평범 글자
    
    static var b14: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold) // 본문 강조 글자
    
    static var r16: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    static var m16: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    static var b16: UIFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    static var b20: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold) // 본문 강조 큰 글자
    
    static var b22: UIFont = UIFont.systemFont(ofSize: 22, weight: .bold) // 날씨 검색 목록 지역 글자
    
    static var M30: UIFont = UIFont.systemFont(ofSize: 30, weight: .medium) // 메인 헤더 배너 지역
    
    static var l80: UIFont = UIFont.systemFont(ofSize: 80, weight: .light) // 메인 헤더 배너 온도
}
