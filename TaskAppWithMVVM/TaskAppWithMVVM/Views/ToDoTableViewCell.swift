//
//  ToDoTableViewCell.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/7/24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    lazy var taskNameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 16, weight: .bold)
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping // 단어 넘김에 관한 설정
        
        return v
    }()
    
    lazy var dueOrCompletedLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 14)
        
        return v
    }()
    
    lazy var completedLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 14)
        
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        selectionStyle = .none
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(dueOrCompletedLabel)
        contentView.addSubview(completedLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dueOrCompletedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            dueOrCompletedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
            dueOrCompletedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            completedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            completedLabel.trailingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            completedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: taskNameLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with task: TaskViewModel) {
        let attributedString = NSMutableAttributedString(string: task.name)
        if task.completed {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSMakeRange(0, attributedString.length))
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            taskNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        
        taskNameLabel.attributedText = attributedString
        
        dueOrCompletedLabel.text = task.completed ? "Completed on: \(task.completedOn.formatted(date: .abbreviated, time: .omitted))" : "Due on: \(task.dueOn.formatted(date: .abbreviated, time: .omitted))"
        
        completedLabel.text = task.completed ? "Completed" : "Not Completed"
        completedLabel.textColor = task.completed ? .green : .red
    }
}
