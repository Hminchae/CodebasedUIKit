//
//  MainCollectionViewCell.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class MainCollectionViewCell: BaseCollectionViewCell {
    
    private var containerView = {
        let view = UIView()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        
        return view
    }()
    
    var categoryIconImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    var categoryTitleLable = {
        let label = UILabel()
        label.font = REFont.m16
        label.textColor = .darkGray
        
        return label
    }()
    
    var categoryTotalToDoLabel = {
        let label = UILabel()
        label.font = REFont.b20
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
    }
    
    func configureContainerView() {
        containerView.addSubview(categoryIconImageView)
        containerView.addSubview(categoryTitleLable)
        containerView.addSubview(categoryTotalToDoLabel)
        
        categoryIconImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.leading.equalTo(containerView.snp.leading).offset(5)
            make.size.equalTo(30)
        }
        
        categoryTitleLable.snp.makeConstraints { make in
            make.top.equalTo(categoryIconImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(categoryIconImageView.snp.horizontalEdges)
            make.height.equalTo(15)
        }
        
        categoryTotalToDoLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryIconImageView.snp.top)
            make.trailing.equalTo(containerView.snp.trailing).inset(5)
            make.size.equalTo(20)
        }
        
    }
}
