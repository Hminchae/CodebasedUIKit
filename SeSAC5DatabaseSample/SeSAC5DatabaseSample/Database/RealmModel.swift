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
    @Persisted(indexed: true) var momoTitle: String // 메모제목(필수)
    @Persisted var momoContent: String? // 메모 내용(옵션)
    @Persisted var money: Int // 금액(필수)
    @Persisted var category: String // 필수
    @Persisted var resisterDate: Date // 필수
    @Persisted var love: Bool // 필수, like는 이미 Realm 이 쓰고 있음
    // isLike 사라지고, love 새로 생김 isLike를 love로 옮겨야함
    @Persisted var folder: String
    
    convenience init(momoTitle: String, memoContent: String?, money: Int, category: String, resisterDate: Date) {
        self.init()
        self.momoTitle = momoTitle
        self.momoContent = momoContent
        self.money = money
        self.category = category
        self.resisterDate = resisterDate
        self.love = false
    }
}
