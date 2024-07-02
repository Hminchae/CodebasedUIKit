//
//  MainBottomTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

import SnapKit

final class MainBottomTableViewCell: BaseTableViewCell {
    
   var toDoTitleLabel = {
        let label = UILabel()
        label.font = REFont.b14
        label.textColor = .label
        label.textAlignment = .left
        
        return label
    }()
    
    var listIconImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet")
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    var toDoCountLabel = {
        let label = UILabel()
        label.font = REFont.b14
        label.textColor = .label
        label.textAlignment = .right
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(listIconImageView)
        contentView.addSubview(toDoTitleLabel)
        contentView.addSubview(toDoCountLabel)
    }
    
    override func configureLayout() {
        listIconImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.height.equalTo(30).priority(.high) // 우선순위를 high로 설정
            make.width.equalTo(30)
        }
        
        toDoTitleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.leading.equalTo(listIconImageView.snp.trailing).offset(5)
        }
        
        toDoCountLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.leading.equalTo(toDoTitleLabel.snp.trailing).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).inset(5)
        }
    }
    
    override func configureView() {
        
    }
}
