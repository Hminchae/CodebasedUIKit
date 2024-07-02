//
//  NewReminderDetailTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class NewReminderDetailTableViewCell: BaseTableViewCell {
    
    let listTitleLabel = {
        let label = UILabel()
        label.font = REFont.m12
        label.textColor = .label
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(listTitleLabel)
    }
    
    override func configureLayout() {
        listTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(10)
        }
    }
}
