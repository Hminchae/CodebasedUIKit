//
//  RealmModel.swift
//  SeSAC5DatabaseSample
//
//  Created by 황민채 on 7/2/24.
//

import Foundation

import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var momoTitle: String // 메모제목(필수)
    @Persisted var momoContent: String? // 메모 내용(옵션)
    @Persisted var money: Int // 금액(필수)
    @Persisted var category: String // 필수
    @Persisted var resisterDate: Date // 필수
    @Persisted var favorite: Bool // 필수
    
    convenience init(momoTitle: String, memoContent: String?, money: Int, category: String, resisterDate: Date) {
        self.init()
        self.momoTitle = momoTitle
        self.momoContent = momoContent
        self.money = money
        self.category = category
        self.resisterDate = resisterDate
        self.favorite = false
    }
}
