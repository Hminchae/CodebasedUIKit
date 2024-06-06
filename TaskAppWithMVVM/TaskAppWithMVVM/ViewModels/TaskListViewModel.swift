//
//  TaskListViewModel.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/6/24.
//

import Foundation

class TaskListViewModel {
    var tasks = [TaskViewModel]()
    
    init() {
        getAll()
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    // 데이터 fetch
    func getAll() {
    }
    
    func numberOfRows(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return numberOfTasks
    }
    
    func getTasksByType() -> (complete: Int, incomplete: Int) {
        let completedCount = tasks.lazy.filter({ $0.completed }).count
        let incompleteCount = tasks.lazy.filter({ !$0.completed }).count
        
        return (completedCount, incompleteCount)
    }
    
    func task(by index: Int) -> TaskViewModel {
        tasks[index]
    }
    
    // 코어 데이터를 호출하여 완료 상태 전환
    func toggleCompleted(task: TaskViewModel) {
        getAll()
    }
    
    // 코어 데이터를 호출하여 Task 삭제
    func deleteItem(task: TaskViewModel) {
        getAll()
    }
}
