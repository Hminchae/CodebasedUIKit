//
//  MyPageTableViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/29/24.
//

import UIKit

final class MyPageTableViewCell: BaseTableViewCell {
    
    var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(3)
        }
    }
}
