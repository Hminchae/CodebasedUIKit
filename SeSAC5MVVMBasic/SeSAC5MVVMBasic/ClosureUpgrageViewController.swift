//
//  ClosureUpgrageViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/11/24.
//

import UIKit

class ClosureUpgrageViewController: UIViewController {
    
    // Closure Context ➡️ 주변환경 ➡️ 캡처리스트
    func basic(param: Int) -> (Int) -> Int {
        let value = param + 20
        
        func append(add: Int) -> Int {
            return value + add
        }
        
        return append
    }
    
    func drawing(item: Int) -> (Int) -> String {
 
        // (int) -> String
        func luckyNumber(number: Int) -> String {
            let result = number * 2
            
            return "\(result)"
        }
        
        return luckyNumber
    }
    
    
    // 외부 함수 내에 ㅅ선언되어 있는 내부 함수는 외부 함수의 생명주기에 영향을 받음
    // 내부 함수의 생명주기는 외불로부터 차단되어 있으며, 따라서 은닉성의 특성을 지님
    // 외부 함수의 생명 주기와 상관없이
    override func viewDidLoad() {
        super.viewDidLoad()
//        let a = drawing(item: 10)
//        // 외부함수의 생명주기가 끝나더라도, 내부함수는 계속 사용할 수 있음
//        print((10))
//        print((10))
//        print((10))
        
        let result = basic(param: 10)
        result(10)
        
        print(result(10)) // 함수가 끝나도 살아있음. ....
        print(basic(param: 10))
        print(result(10))
    }
}
