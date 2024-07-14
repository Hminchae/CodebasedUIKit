//
//  ReviewCollectionViewCell.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit

final class ReviewCollectionViewCell: UICollectionViewCell {
    static let id = "ReviewCollectionViewCell"
    
    private let contentLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentLabel)
        
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(14)
        }
    }
    
    public func config(content: String) {
        contentLabel.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
