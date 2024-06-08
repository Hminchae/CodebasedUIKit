//
//  UILabel+Extension.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

extension UILabel {
    func setBallUI(_ text: Int, width: Double) {
        self.text = String(text)
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 20)
        self.clipsToBounds = true
        self.layer.cornerRadius = width / 2
        self.textAlignment = .center
        
        switch text {
        case 1...9:
            self.backgroundColor = #colorLiteral(red: 0.9923834205, green: 0.7945680022, blue: 0.002898791805, alpha: 1)
        case 10...19:
            self.backgroundColor = #colorLiteral(red: 0.4120162725, green: 0.7748999596, blue: 0.9445131421, alpha: 1)
        case 20...29:
            self.backgroundColor = #colorLiteral(red: 0.9982922673, green: 0.4414684772, blue: 0.4473998547, alpha: 1)
        case 30...45:
            self.backgroundColor = #colorLiteral(red: 0.6588235497, green: 0.6588235497, blue: 0.6588235497, alpha: 1)
        default:
            self.backgroundColor = .white
        }
    }
    
    func setPlusLabelUI() {
        self.text = "+"
        self.textColor = .label
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 20)
        self.backgroundColor = .clear
    }
}
