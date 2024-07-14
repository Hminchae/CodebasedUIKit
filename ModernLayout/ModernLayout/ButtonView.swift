//
//  ButtonView.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import UIKit

final class ButtonView: UIView {
    
    let tvButton = {
        let button = UIButton()
        button.setTitle("TV", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.configuration = UIButton.Configuration.bordered()
        
        return button
    }()
    
    let movieButton = {
        let button = UIButton()
        button.setTitle("MOVIE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.configuration = UIButton.Configuration.bordered()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }
    
    private func setUI() {
        addSubview(tvButton)
        addSubview(movieButton)
        
        tvButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        movieButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tvButton.snp.trailing).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            isUserInteractionEnabled = true // 상호작용 설정
            setUI()
        }

}
