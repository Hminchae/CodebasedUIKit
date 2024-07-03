//
//  ListDetailTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

// 컴포너트 셀 : 라디오버튼과 타이틀 있는 셀, 나중엔 날짜 추가까지 해야됨 ㅠㅜㅠ
final class ListDetailTableViewCell: BaseTableViewCell {
    
    var radioButton = RadioButton(style: .unselected)
    
    var titleTextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .label
        
        return textField
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(radioButton)
        contentView.addSubview(titleTextField)
    }
    
    override func configureLayout() {

        radioButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.leading.equalTo(radioButton.snp.trailing).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
        }
    }
}

