//
//  SignViewController.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/12/24.
//

import UIKit

import SnapKit

class SignViewController: UIViewController {
    
    lazy var nicknameField = {
        let view = BlackRadiusTextField()
        view.placeholder = "닉네임을 입력해보세요"
        view.placeholder = Constant.Field.nickname.rawValue // -> enum raw value
        view.placeholder = Constant.Field1.nickname // enum static let
        //print(APIURL().kakaoBookUrl)
        view.font = Constant.Font.bold15
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(nicknameField)
        
        nicknameField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
    
    // 1. 함수 & 매개변수
    // 2. extension
    // 3. custom view
}
