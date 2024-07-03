//
//  RealmSwift.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import Foundation

import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var momoTitle: String
    @Persisted var momoContent: String?
    
    convenience init(momoTitle: String, memoContent: String?) {
        self.init()
        self.momoTitle = momoTitle
        self.momoContent = momoContent
    }
}
