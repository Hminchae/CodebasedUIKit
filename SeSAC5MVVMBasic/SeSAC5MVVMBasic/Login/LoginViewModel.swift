//
//  LoginViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/9/24.
//

import Foundation

class LoginViewModel {
    // 실시간으로 달라지는 데이터를 감지 -> 그런데- 조금 숨겨보고싶다!
    var inputId: Observable<String?> = Observable(nil)
    var inputPassword: Observable<String?> = Observable(nil)
    
    var outputValidationText = Observable("")
    var outputValid = Observable(false)

    init() {
        print("ViewModel Init")
        inputId.bind { _ in
            self.validation() //<- 값이 변경될때마다 이 함수구문을 closure 에 넣어 value 의 didset 에 위치
        }
        
        inputPassword.bind { _ in
            self.validation()
        }
    }
    
    private func validation() {
        
        guard let id = inputId.value, let pw = inputPassword.value else {
            return
        }
        
        if id.count >= 3 && pw.count > 5 {
            print("유효성 통과")
            outputValid.value = true
            outputValidationText.value = "통과요~~"
        } else {
            print("유효성 못통과")
            outputValid.value = false
            outputValidationText.value = "통과X요~~"
        }
    }
}

