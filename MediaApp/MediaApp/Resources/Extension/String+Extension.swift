//
//  String+Extension.swift
//  MediaApp
//
//  Created by 황민채 on 6/30/24.
//

import UIKit

extension String {
    // 날짜 데이터 포메터
    func transDateString(from inputFormat: String, to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            let formattedDateString = dateFormatter.string(from: date)
            return formattedDateString
        }
        return nil
    }
}
