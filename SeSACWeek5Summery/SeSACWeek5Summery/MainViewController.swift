//
//  MainViewController.swift
//  SeSAC5Week4Summery
//
//  Created by jack on 6/13/24.
//

import UIKit
import SnapKit

struct User {
    let name: String
    let age: Int
    
    var introduce: String {
        return "\(name): \(age)"
    }
}

enum Filter: Int {
    case seoul // 0 💡 0 ~ 하나씩 자동으로 올라가게 됨, 이전 값 기준으로 + 1이 됨
    case busan // 1
    case daegu // 2
}

enum SettingOptions: String, CaseIterable {
    case total = "전체 설정"
    case personal = "개인 설정"
    case others = "기타"
    
    var subOptions: [String] { // ⬅️ 인스턴스 연산 프로퍼티
        // if self == .total { } 👌
        // ⬇️ 🫶
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
        
    }
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    // ❗️ let list = ["공지사항", "실험실", "버전정보"] -> 열거형을 사용하여 변경!(CaseIterable)⬇️
    // 💡 let list = SettingOptions.allCases -> 그럼에도 이렇게 굳이 부를 필요도 ❌
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(SettingOptions.allCases[0].rawValue)
        print(SettingOptions.allCases[1].rawValue)
        print(SettingOptions.allCases[2].rawValue)
        
        print(SettingOptions.allCases[0].subOptions)
        print(SettingOptions.allCases[1].subOptions)
        print(SettingOptions.allCases[2].subOptions)
        
        view.backgroundColor = Color.white
        title = "메인 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "로그아웃", 
                                                            style: .plain, 
                                                            target: self,
                                                            action: #selector(rightBarButtonClicked))
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    @objc func rightBarButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = UINavigationController(rootViewController: SignInViewController())
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].subOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        // ✅ 이렇게 써~
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        
        return cell
    }
    
}
