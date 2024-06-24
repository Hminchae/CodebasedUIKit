//
//  ViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // showAlert(title: "테스트", message: "테스트함다")
        // viewDidLoad() 에서 Alert X
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert(title: "테스트", message: "저장저장?", ok: "저장") {
            print("저장되었슈")
        }
        
        showAlert2(title: "테스트", message: "저장저장?", ok: "저장") { _ in
            print("저장 2222")
        }
        
        // {_ in 의 기능이 밖으로 나옴!
    }
}

