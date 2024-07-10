//
//  RealmModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

import RealmSwift

class Money: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var market: String //KRW-BTC
    @Persisted var name: String //비트코인
    @Persisted var won: Int
    
    convenience init(market: String, name: String, won: Int) {
        self.init()
        self.market = market
        self.name = name
        self.won = won
    }
}
