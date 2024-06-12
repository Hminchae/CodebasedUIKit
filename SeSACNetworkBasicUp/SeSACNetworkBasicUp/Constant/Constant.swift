//
//  Constant.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/12/24.
//

import UIKit

// 🧡 초기화가 되냐 안되냐에 따라서 분기하여 생각해보기
/*
 case + rawValue
 - Int, String
 - .rawValue
 - Raw value for enum case is not unique
 - nested enum
 */

enum Constant {
    // ❌ 이렇게 못써요
    //enum Font: UIFont {
    //    case bold15 = .boldSystemFont(ofSize: 15)
    //}
    enum Color {
        // ✏️ Nested Enums
        enum View {
            static let viewBg = UIColor.white
            static let viewText = UIColor.red
            static let viewBorder = UIColor.black
        }
        
        enum Normal {
            static let bg = UIColor.white
            static let text = UIColor.red
            static let border = UIColor.black
        }
    }
    // ✅ 이렇게 쓰세요
    enum Font {
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
    }

    enum Field: String {
        // ❌⬇️ 저장 프로퍼티 + 인스턴스 프로퍼티
        //var nickname = "황민채"
        case nickname = "닉네임을 입력해주세요"
        case email = "이메일을 입력해주세요"
        case password = "비밀번호를 입력해주세요"
    }

    enum Field1 {
        static let nickname = "닉네임을 입력해주세요"
        static let email = "이메일을 입력해주세요"
        static let password = "비밀번호를 입력해주세요"
    }

    enum Spacing: Int {
        case horizontal = 24 // leading, trailing
        case button = 8
        // ❌ 이렇게 못써요.. 같은 리터럴을 사용하고 싶을때 중복된 데이터를 관리하기 쉬워
        // case fieldHeight = 8
        
        // ✅ 이것도 가능
        case mee, merong, haha = 11
    }

    enum Radius: Int {
        case textField = 6
        case button = 8
        case cell = 12
    }
}
