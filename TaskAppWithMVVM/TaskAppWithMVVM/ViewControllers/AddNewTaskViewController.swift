//
//  AddNewTaskViewController.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/6/24.
//

import UIKit

class AddNewTaskViewController: UIViewController {
    
    lazy var taskNameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Task Name"
        
        return v
    }()
    
    lazy var taskNameTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "Enter task name"
        v.borderStyle = .roundedRect
        
        return v
    }()
    
    lazy var dueOnLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Due On"
        
        return v
    }()
    
    lazy var dueOnDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.datePickerMode = .date
        v.minimumDate = Date()
        
        return v
    }()
    
    let viewModel = AddNewTaskViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Add New Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        
        [taskNameLabel, taskNameTextField, dueOnLabel, dueOnDatePicker].forEach { subViewToAdd in
            view.addSubview(subViewToAdd)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            taskNameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            dueOnLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 8),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            
            dueOnDatePicker.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 8),
            dueOnDatePicker.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor, constant: 8)
        ])
    }
    
    // MARK: Action Function
    @objc func saveTask() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task name can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            return
        }
        
        let dueOn = dueOnDatePicker.date
        viewModel.addTask(name: taskName, dueOn: dueOn)
        
        navigationController?.popViewController(animated: true)
    }
}
