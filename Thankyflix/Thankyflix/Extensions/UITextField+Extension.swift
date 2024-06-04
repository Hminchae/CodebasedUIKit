//
//  UITextField+Extension.swift
//  Thankyflix
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

extension UITextField {
    func setLoginTextField(_ placeholder: String) {
        self.placeholder = placeholder
        self.tintColor = .white
        self.textColor = .black
        self.backgroundColor = .lightGray
        self.borderStyle = .none
        self.layer.cornerRadius = 8
        self.textAlignment = .center
    }
}

