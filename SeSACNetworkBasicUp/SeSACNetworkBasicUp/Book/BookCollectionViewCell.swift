//
//  BookCollectionViewCell.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/11/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
