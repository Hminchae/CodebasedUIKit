//
//  CreditViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class CreditViewController: UIViewController {
    
    var targetId: Int?
    var list: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "출연/제작"
        self.navigationController?.navigationBar.tintColor = .pointColor // 백버튼의 틴트 색상을 변경
        //print(targetId)
        if let targetId = targetId {
            callRequest(targetId)
        }
    }
    
    func callRequest(_ id: Int) {
        let url = MediaAPI.creditURL(movieId: id).url
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language" : "ko-KR",
        ]
        AF.request(url, method: .get, parameters: para, headers: header).responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                print("Success")
                print(value.cast)
                self.list = value.cast
            case .failure(let error):
                print(error)
            }
        }
    }
}
