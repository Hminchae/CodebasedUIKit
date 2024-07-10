//
//  CoinError.swift
//  iCrypto
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

struct CoinStatus: Decodable {
    let status: CoinError
}

struct CoinError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
