//
//  Lotto.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import Foundation

struct Lotto: Decodable {
    let returnValue : String
    let lottoDate : String
    let num1 : Int
    let num2 : Int
    let num3 : Int
    let num4 : Int
    let num5 : Int
    let num6 : Int
    let num7 : Int
    let prizeMoney : Int
    let lottoRound : Int
    
    enum CodingKeys: String, CodingKey {
        case returnValue = "returnValue"
        case lottoDate = "drwNoDate"
        case num1 = "drwtNo1"
        case num2 = "drwtNo2"
        case num3 = "drwtNo3"
        case num4 = "drwtNo4"
        case num5 = "drwtNo5"
        case num6 = "drwtNo6"
        case num7 = "bnusNo"
        case prizeMoney = "firstWinamnt"
        case lottoRound = "drwNo"
    }
}
