//
//  TextFieldStyle.swift
//  SeSACWeek5Summery
//
//  Created by 황민채 on 6/13/24.
//

import Foundation
// ⬇️ 멤버와 값의 분리
// rawvalue(원시값)
enum TextFieldStyle: String {
    case email = "이메일을 입력해주세요"
    case password = "비밀번호를 입력해주세요"
    case nickname // ⬅️ rawvalue nickname을 가지고 있음
}
