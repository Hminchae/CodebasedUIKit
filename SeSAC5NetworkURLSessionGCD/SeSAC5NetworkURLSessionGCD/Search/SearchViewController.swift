//
//  SearchViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

import SnapKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    //⬇️viewDidLoad보다 먼저 실행됨
    //loadView: 뷰컨트롤러의 루트뷰를 생성해주는 기능
    //super.loadView()절대 호출하지 말아야 함 ❌
    override func loadView() {
        print(#function)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

    }
}
