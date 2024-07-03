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
        textField.font = REFont.r16
        textField.tintColor = .darkGray
        textField.textColor = .label
        
        return textField
    }()
    
    let separatorView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    let memoTextField = {
        let textField = UITextField()
        textField.placeholder = "메모"
        textField.font = REFont.r16
        textField.tintColor = .darkGray
        textField.textColor = .label
        
        return textField
    }()
    
    var delegate: NewReminderContentsDelegate?
    
    override func configureHierarchy() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(separatorView)
        contentView.addSubview(memoTextField)
    }
    
    override func configureLayout() {
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.bottom.equalTo(separatorView.snp.top).inset(2)
            make.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(memoTextField.snp.top).inset(2)
            make.height.equalTo(0.5)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(150)
        }
    }
    
    override func configureView() {
        titleTextField.addTarget(self, action: #selector(titleChanged(_:)), for: .editingChanged)
        memoTextField.addTarget(self, action: #selector(memoChanged(_:)), for: .editingChanged)
    }
    
    @objc private func titleChanged(_ textField: UITextField) {
        delegate?.passTitle(textField.text ?? "")
    }
    
    @objc private func memoChanged(_ textField: UITextField) {
        delegate?.passMemo(textField.text ?? "")
    }
}
