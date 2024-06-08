//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9602500796, green: 0.989430964, blue: 0.9885126948, alpha: 1)
        title = "설정"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3222457469, green: 0.4339936972, blue: 0.4861731529, alpha: 1)
    }
}
