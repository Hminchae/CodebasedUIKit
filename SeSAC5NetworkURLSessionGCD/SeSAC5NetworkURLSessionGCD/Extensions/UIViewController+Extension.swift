//
//  UIViewController+Extension.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

extension UIViewController {
    // showAlert 은 present로 얼럿이 뜨는 순간 생명주기가 다함
    func showAlert(title: String, message: String, ok: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .default) {_ in 
            completionHandler()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func showAlert2(title: String, message: String, ok: String, completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .default, handler: completionHandler)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
