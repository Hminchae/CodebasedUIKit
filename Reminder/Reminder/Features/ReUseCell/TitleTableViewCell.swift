//
//  NewReminderDetailTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

// 컴포넌트 셀 : 제목 하나만 있는 셀
final class TitleTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let label = UILabel()
        label.font = REFont.m16
        label.textColor = .label
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
        }
    }
}
