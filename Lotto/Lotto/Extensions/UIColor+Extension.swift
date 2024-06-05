//
//  UIColor+Extension.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.5)
    }
}
