//
//  SummaryTableViewCell.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/7/24.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.backgroundColor = .secondarySystemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        return stackView
    }()
    
    lazy var completedLabel: UILabel = {
        let compltedLabel = UILabel()
        compltedLabel.font = .boldSystemFont(ofSize: 20)
        
        return completedLabel
    }()
    
    lazy var incompletedLabel: UILabel = {
        let incompletedLabel = UILabel()
        incompletedLabel.font = .boldSystemFont(ofSize: 20)
        
        return incompletedLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        stackView.addArrangedSubview(incompletedLabel)
        stackView.addArrangedSubview(completedLabel)
        
        contentView.addSubview(stackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(completed: String, incompleted: String) {
        completedLabel.text = "✅ Completed: \(completed)"
        incompletedLabel.text = "📝 TODO: \(incompleted)"
    }
}
