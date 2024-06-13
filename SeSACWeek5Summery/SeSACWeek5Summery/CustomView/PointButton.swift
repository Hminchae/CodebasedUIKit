//
//  PointButton.swift
//  SeSACWeek5Summery
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

class PointButton: UIButton {
    
    // 💡 내가 원하는 이니셜라이저를 만들고싶어
    init(title: String) {
        super.init(frame: .zero) // 일단 없는 채로 만들고싶어
        setTitle(title, for: .normal)
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.black
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
