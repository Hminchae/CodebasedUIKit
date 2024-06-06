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
    
    // fetch data from core data and populate tasks
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
    
    // call core data to toggle completed state
    func toggleCompleted(task: TaskViewModel) {
        getAll()
    }
    
    // call core data to delete the task
    func deleteItem(task: TaskViewModel) {
        getAll()
    }
}
