//
//  Reminder.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import Foundation

struct Reminder {
    var title: String
    var memo: String?
    var detail: [ReminderDetail]?
    var category: Value.Category
}

struct ReminderDetail {
    var date: Date?
    var time: String?
    var tag: String?
    var location: String?
    var whenMesseging: String?
    var flag: String?
    var priority: String?
    var image: String?
    var url: String?
}
