//
//  ReuseIdentifierProtocol.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
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

extension UICollectionViewController : ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell : ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
