//
//  HeaderView.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    static let id = "HeaderView"
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
