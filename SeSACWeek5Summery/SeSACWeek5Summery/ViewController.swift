//
//  ViewController.swift
//  SeSACWeek5Summery
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    let signButton = PointButton(title: "로그인")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.white
        view.addSubview(signButton)
        
        signButton.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }


}

