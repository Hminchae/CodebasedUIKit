//
//  MainCollectionViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainHeaderCollectionViewCell: BaseCollectionViewCell {
    
    private var containerView = {
        let view = UIView()
        view.backgroundColor = .container
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    var categoryIconContainer = UIView()
    var categoryIconImageView = UIImageView()
    
    var categoryTitleLable = {
        let label = UILabel()
        label.font = REFont.m16
        label.textColor = .darkGray
        
        return label
    }()
    
    var categoryTotalToDoLabel = {
        let label = UILabel()
        label.font = REFont.b24
        label.textColor = .label
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(containerView)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        configureContainerView()
        cofigureIconContainerView()
    }
    
    func cofigureIconContainerView() {
        categoryIconContainer.addSubview(categoryIconImageView)
        
        categoryIconContainer.layer.cornerRadius = 15
        categoryIconContainer.clipsToBounds = true
        
        categoryIconImageView.tintColor = .white
        categoryIconImageView.contentMode = .scaleAspectFit
        
        categoryIconImageView.snp.makeConstraints { make in
            make.center.equalTo(categoryIconContainer)
            make.size.equalTo(20)
        }
    }
    
    func configureContainerView() {
        containerView.addSubview(categoryIconContainer)
        containerView.addSubview(categoryTitleLable)
        containerView.addSubview(categoryTotalToDoLabel)
        
        categoryIconContainer.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.size.equalTo(30)
        }
        
        categoryTitleLable.snp.makeConstraints { make in
            make.top.equalTo(categoryIconContainer.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
            make.height.equalTo(15)
        }
        
        categoryTotalToDoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryIconContainer.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).inset(5)
            make.size.equalTo(20)
        }
        
    }
}
