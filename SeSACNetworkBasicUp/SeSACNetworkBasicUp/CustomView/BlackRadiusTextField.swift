//
//  BlackRadiusTextField.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/12/24.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    // 슈퍼클래스에 구현된 init..
    // 코드베이스로 코드를 구성할 때 호출되는 초기화 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .boldSystemFont(ofSize: 15)
        textColor = .brown
        textAlignment = .center
        keyboardType = .default
        borderStyle = .none
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        backgroundColor = .white
    }
    
    // 스토리보드로 구성할 때 호출되는 초기화 구문
    // ✅ 프로토콜이 원산지
    // ❌ 실패가능한 이니셜라이저(Failable Initalizer)
    // Required Initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//protocol SeSAC {
//    init()
//}
//
//class Mentor: SeSAC {
//    
//    required init() {
//        
//    }
//    
//    func mentoring() {
//        
//    }
//}
//
//class Jack: Mentor {
//    
//    override required init() {
//        <#code#>
//    }
//    
//    override func mentoring() {
//        super.mentoring()
//        
//    }
//}
//
