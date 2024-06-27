//
//  SearchViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import UIKit

import SnapKit

struct User {
    let name = "고래밥"
    static let originalName = "jack"
}
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
        let button = UIButton()
        configureBorder(button)
        configureBorder(mainView.resultLabel)
        
        let nickname = "고래밥"
        let nick = "Thanky"
        
        let user = User()
        print(type (of: user.name))
        print(type(of: user)) // User라는 인스턴스의 타입
        print(type(of: User.self))
        print(type(of: String.self)) // 메타타입이 가지고 있는 값
        
        // 고래밥 -> String/String.self -> String.Type
        User.self.originalName // == User.origianlName 메타타입의 값
        
        let cast = DummyData(main: "", sub: 13)
        let todo = DummyData(main: false, sub: false)
        let test = DummyData(main: 3.0, sub: "하하하")
        
        /*
        TMDBManager.shared.callRequest { lotto, error in
            // DispatchQueue.main.async { // ⬅️ 🤔 이거 좀 귀찮나...(TMDBManager 참고
            //}
            
            //guard error != nil else { return } // <- 이게 통과가 되어야 하기 때문에?
            guard error != nil, let lotto = lotto else { return }
            self.mainView.resultLabel.text = lotto.drwNoDate
            // 둘다 만족할 수 있는 경우의 수가 없음
        }
         */
            
        NetworkManager.shared.trending(api: .trendingMovie, model: Trending.self) { value, Error in
            print(value?.results)
        }
    }
}
