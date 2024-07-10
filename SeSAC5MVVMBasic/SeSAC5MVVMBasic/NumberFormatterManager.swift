//
//  NumberFormatterManager.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

class NumberFormatterManager {
    
    static let shared = NumberFormatterManager()
    
    private init() { }
    
    static let numberFormatter = {
        let format = NumberFormatter()
        format.numberStyle = .decimal
      
        return format
    }()
    
    static let dateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
      
        return format
    }()
}
