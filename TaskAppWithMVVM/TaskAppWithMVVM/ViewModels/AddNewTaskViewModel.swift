//
//  AddNewTaskViewModel.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/6/24.
//

import Foundation

class AddNewTaskViewModel {
    // 코어데이터를 호출하고 새로운 Task를 추가
    func addTask(name: String, dueOn: Date) {
        CoreDataManager.shared.addNewTask(name: name, dueOn: dueOn)
    }
}
