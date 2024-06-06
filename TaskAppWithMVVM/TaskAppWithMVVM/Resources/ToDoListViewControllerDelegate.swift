//
//  ToDoListViewControllerDelegate.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/7/24.
//

import UIKit

extension ToDoListViewController: UITableViewDelegate {
    
    // 옆으로 밀어서 삭제하는 그 친구
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.task(by: indexPath.row)
        
        let completeAction = UIContextualAction(
            style: .normal,
            title: task.completed ? "Not Completed" : "Complete"
        ) { [weak self] (action, view, completionhandler) in
            self?.completeTask(at: indexPath)
            completionhandler(true)
        }
        completeAction.backgroundColor = task.completed ? .systemRed : .systemGreen
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func completeTask(at indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        viewModel.toggleCompleted(task: task)
        
        if task.completed {
            celebrationAnimationView.isHidden = false
            celebrationAnimationView.play { finished in
                self.celebrationAnimationView.isHidden = finished
            }
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let task = viewModel.task(by: indexPath.row)
        viewModel.deleteItem(task: task)
        tableView.reloadData()
    }
}
