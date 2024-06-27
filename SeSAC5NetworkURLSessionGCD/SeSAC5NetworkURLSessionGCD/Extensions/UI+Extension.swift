//
//  UI+Extension.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/27/24.
//

import UIKit

struct Cast {
    let name: String
    let age: Int
}

struct Movie {
    let name: String
    let runtime: Int
}

struct DummyData<BRAN, DEN> {
    let main: BRAN
    let sub: DEN
}

extension UIViewController {
    func configureBorder<THANKY: UIView>(_ view: THANKY) { // ✏️ (UILabel) -> Void
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .clear
    }
    
    //⬇️ 이렇게 안 해도 된다~!
//    func configureBorder(_ view: UIButton) { // ✏️ (UIButton) -> Void
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.cornerRadius = 8
//        view.clipsToBounds = true
//        view.backgroundColor = .clear
//    }
//    
//    func configureBorder(_ view: UITextField) { // ✏️ (UITextField) -> Void
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.cornerRadius = 8
//        view.clipsToBounds = true
//        view.backgroundColor = .clear
//    }
    
//     👛 제네릭, 범용타입, < >
//     Type Parameter >> Placeholder 와 같은 역할
//     타입이 뭔지 모르지만 특정 타입이라는 거는 알 수 있음
//     호출 시 타입이 결정됨
//     Type Constraints - 프로토콜 제약, 클래스 제약
    func plus<T: Numeric>(a: T, b: T) -> T {
        return a + b
    }
}
