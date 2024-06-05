//
//  ReuseIdentifierProtocol.swift
//  Lotto
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UITableViewController : ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell : ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
