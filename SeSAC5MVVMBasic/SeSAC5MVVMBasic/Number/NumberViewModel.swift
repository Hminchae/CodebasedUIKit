//
//  NumberViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/9/24.
//

import Foundation

class NumberViewModel {
    
    private let exchangeRate = 1300.0
    
    var outputAmount = "" // 밖에서 보여줄 친구
    var inputAmount: String? = "" {
        didSet {
            //print("값이 변함: \(inputAmount)")
            validation(inputAmount)
        }
    }
    
    private func validation(_ value: String?) {
        
        // 1.
        guard let text = value else {
            outputAmount = ""
            return
        }
        
        // 2.
        if text.isEmpty {
            outputAmount = "값을 입력해주세요"
            return // 이후 코드 실행되지 않게끔
        }
        
        // 3.
        guard let num = Int(text) else {
            outputAmount = "숫자만 입력해주세요"
            return
        }
        
        // 4.
        if num > 0, num <= 10000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal
            
            let wonResult = format.string(from: num as NSNumber)!
            outputAmount = "₩" + wonResult
            
            //            let converted = Double(num) / exchangeRate
            //
            //            let convertedFormat = NumberFormatter()
            //            convertedFormat.numberStyle = .currency
            //            convertedFormat.currencyCode = "USD"
            //
            //            let convertedResult = convertedFormat.string(from: converted as NSNumber)
            //            convertedAmountLabel.text = convertedResult
            
        } else {
            outputAmount = "1,000만원 이하를 입력해주세요"
        }
    }
}
