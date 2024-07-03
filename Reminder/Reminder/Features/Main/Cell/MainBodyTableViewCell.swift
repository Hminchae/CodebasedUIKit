//
//  MainBottomTableViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

import SnapKit

// 컴포넌트 셀 : 아이콘과 타이틀, 숫자가 있는 셀
final class MainBodyTableViewCell: BaseTableViewCell {
    
    var categoryIconContainer = UIView()
    var categoryIconImageView = UIImageView()
    
    var toDoTitleLabel = {
        let label = UILabel()
        label.font = REFont.m16
        label.textColor = .label
        label.textAlignment = .left
        
        return label
    }()
    
    var toDoCountLabel = {
        let label = UILabel()
        label.font = REFont.b14
        label.textColor = .lightGray
        label.textAlignment = .right
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(categoryIconContainer)
        contentView.addSubview(toDoTitleLabel)
        contentView.addSubview(toDoCountLabel)
    }
    
    override func configureLayout() {

        categoryIconContainer.snp.makeConstraints { make in
            make.centerY.equalTo(toDoTitleLabel.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.size.equalTo(30)
        }
        
        toDoTitleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.leading.equalTo(categoryIconContainer.snp.trailing).offset(8)
        }
        
        toDoCountLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.leading.equalTo(toDoTitleLabel.snp.trailing).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).inset(5)
        }
    }
    
    override func configureView() {
        cofigureIconContainerView()
    }
    
    func cofigureIconContainerView() {
        categoryIconContainer.addSubview(categoryIconImageView)
        
        categoryIconContainer.layer.cornerRadius = 15
        categoryIconContainer.clipsToBounds = true
        
        categoryIconImageView.tintColor = .white
        categoryIconImageView.contentMode = .scaleAspectFit
        categoryIconImageView.image = UIImage(systemName: "list.bullet")
        
        categoryIconImageView.snp.makeConstraints { make in
            make.center.equalTo(categoryIconContainer)
            make.size.equalTo(20)
        }
    }
}
