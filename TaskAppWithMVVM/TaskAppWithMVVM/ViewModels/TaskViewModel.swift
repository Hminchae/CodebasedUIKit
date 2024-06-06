//
//  TaskViewModel.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/6/24.
//

import Foundation

struct TaskViewModel {
    private var task: Task // 코어데이터 모델
    
    init(task: Task) {
        self.task = task
    }
    
    var id: UUID {
        task.id ?? UUID()
    }
    
    var name: String {
        task.name ?? ""
    }
    
    var dueOn : Date {
        task.dueOn ?? Date()
    }
    
    var completedOn: Date {
        task.completedOn ?? Date()
    }
    
    var completed: Bool {
        task.completed // Bool은 기본적으로 nil을 가지고 있기 때문에 다른 것과 다르게 Nil-Coalescing 쓰지 않았음
    }
}
