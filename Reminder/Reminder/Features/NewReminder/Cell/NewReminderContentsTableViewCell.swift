//
//  NewReminderContentsTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class NewReminderContentsTableViewCell: BaseTableViewCell {
    let titleTextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.font = REFont.m12
        textField.tintColor = .darkGray
        textField.textColor = .label
        
        return textField
    }()
    
    let separatorView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    let memoTextField = {
        let textField = UITextField()
        textField.placeholder = "메모"
        textField.font = REFont.m12
        textField.tintColor = .darkGray
        textField.textColor = .label
        
        return textField
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(separatorView)
        contentView.addSubview(memoTextField)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(10)
        }
        
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.top.equalTo(titleTextField.snp.bottom)
            make.height.equalTo(1)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.top.equalTo(separatorView.snp.bottom)
            make.height.equalTo(150)
        }
    }
}
