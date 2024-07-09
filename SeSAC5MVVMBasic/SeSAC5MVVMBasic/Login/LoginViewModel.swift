//
//  LoginViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/9/24.
//

import Foundation
import UIKit

class Observable {
    
    var closure: (() -> Void)?
    
    var value: String {
        didSet {
            print("didSet")
            closure?() // <- 일급객체의 속성
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
    
    func bind(closure: @escaping () -> Void) { //매개변수에 반가워가 들어갔음
        closure() // <- 인스턴스 첫 생성 시 안녕방가워를 호출하기 위함
        self.closure = closure
    }
}

class LoginViewModel {
    
    // 실시간으로 달라지는 데이터를 감지 -> 그런데- 조금 숨겨보고싶다!
    var inputId: String? = "" {
        didSet {
            Observable("jack")
            validation()
        }
    }
    
    var inputPassword: String? = ""{
        didSet {
            validation()
        }
    }
    
    var outputValidationText = ""
    var outputValid = false

    private func validation() {
        
        guard let id = inputId, let pw = inputPassword else {
            return
        }
        
        if id.count >= 3 && pw.count > 5 {
            print("유효성 통과")
            outputValid = true
            outputValidationText = "통과요~~"
        } else {
            print("유효성 못통과")
            outputValid = false
            outputValidationText = "통과X요~~"
        }
    }
}

