//
//  SearchTextField.swift
//  MediaApp
//
//  Created by 황민채 on 6/13/24.
//  💡 서치 vc 서치바 이거 이후에 유아이스크린도 구현하기

import UIKit

class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        textAlignment = .left
        keyboardType = .default
        borderStyle = .none
        layer.cornerRadius = CGFloat(Constant.Radius.searchBar)
        backgroundColor = UIColor.container
        font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
