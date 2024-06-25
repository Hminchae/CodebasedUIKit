//
//  BaseCollectionViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
