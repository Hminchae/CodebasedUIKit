//
//  ToDoListViewControllerDataSource.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/7/24.
//

import UIKit

extension ToDoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            
            let taskSummary = viewModel.getTasksByType()
            cell.configure(completed: taskSummary.complete.description, 
                           incompleted: taskSummary.incomplete.description)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let task = viewModel.task(by: indexPath.row)
        cell.configure(with: task)
        
        return cell
    }
}
