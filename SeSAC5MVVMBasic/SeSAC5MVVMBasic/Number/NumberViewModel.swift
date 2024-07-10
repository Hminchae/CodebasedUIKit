//
//  NumberViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/9/24.
//

import Foundation

class NumberViewModel {
    
    private let exchangeRate = 1300.0
    
    var inputAmount: Observable<String?> = Observable("")
    var outputAmount: Observable<String?> = Observable("")
    
    static let format = NumberFormatter() // 연산비용 많을 가능성
    
    init() {
        inputAmount.bind { _ in
            self.validation()
        }
    }
    
    private func validation() {
        
        // 1.
        guard let text = inputAmount.value else {
            outputAmount.value = ""
            return
        }
        
        // 2.
        if text.isEmpty {
            outputAmount.value = "값을 입력해주세요"
            return // 이후 코드 실행되지 않게끔
        }
        
        // 3.
        guard let num = Int(text) else {
            outputAmount.value = "숫자만 입력해주세요"
            return
        }
        
        // 4.
        if num > 0, num <= 10000000 {
            
            let format = NumberFormatterManager.numberFormatter
            
            let wonResult = format.string(from: num as NSNumber)!
            outputAmount.value = "₩" + wonResult
            
            //            let converted = Double(num) / exchangeRate
            //
            //            let convertedFormat = NumberFormatter()
            //            convertedFormat.numberStyle = .currency
            //            convertedFormat.currencyCode = "USD"
            //
            //            let convertedResult = convertedFormat.string(from: converted as NSNumber)
            //            convertedAmountLabel.text = convertedResult
            
        } else {
            outputAmount.value = "1,000만원 이하를 입력해주세요"
        }
    }
}

// ✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️
// ViewModel의 기준을 잡는 제일 기초적인 핵심은
// UIKit을 import 하지 않는 것
// 즉, UI를 담당하는 곳이 아니다 라는 것

// ViewModel에서는 엄격한 기준을 세워
// View에서는 판단하는 로직이 없이 값만 가져올 수 있도록하고
// ViewModel에서 모든 것을 판단하도록
// ✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️
