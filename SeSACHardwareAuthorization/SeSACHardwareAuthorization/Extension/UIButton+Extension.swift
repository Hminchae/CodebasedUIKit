//
//  UIButton+Extension.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/17/24.
//

import UIKit

extension UIButton.Configuration {
    // ❌ 인스턴스 저장 프로퍼티
    // var nickname = "너?"
    // 🆗 타입 저장 프로퍼티
    static var name = "나?"
    
    static func blackStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "앗뇽"
        //configuration.baseBackgroundColor = .yellow
        configuration.subtitle = "앗뇽이란 안녕의 다른말.."
        configuration.cornerStyle = .large
        configuration.baseForegroundColor = .label
        configuration.image = UIImage(systemName: "airpod.gen3.right")
        configuration.imagePlacement = .trailing
        
        return configuration
    }
}
