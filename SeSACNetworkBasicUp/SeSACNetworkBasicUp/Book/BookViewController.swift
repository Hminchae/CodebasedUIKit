//
//  BookViewController.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/10/24.
//

import UIKit

import Alamofire

class BookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callRequest()
        //callRequestKoGPT()
    }
    
    func configureView() {
        print(#function)
        view.backgroundColor = .systemBlue
        
    }
    /* ✅
     1. url
     2. query string
     3. http header - authorization
     4. request
     5. response(ex. reponseString)
     6. struct
     7.
     8. HTTP 상태코드
     */
    
    /* 😱
     1. 식판 오류가 아닌데 왜 식판 오류 문구가 뜰까 ?
     >> 성공했을 때에 대한 식판이라서
     2. success가 실행이 되는걸까 ? failed가 실행이 되는걸까?
     3. success랑 failed 기준이 뭘까?
     >> 상태코드! Almaofire 에서는 200 ~ 300 사이면 성공이라고 판단 -> 문서에 명세
     >> StatusCode / struct
     */
    func callRequest() {
        print(#function)
        let url = "\(APIURL.naverURL)query=&display=20&start=1"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverKey,
            "X-Naver-Client-Secret": APIKey.naverKey2
        ]
        AF.request(url, method: .get, headers: header)
          .validate(statusCode: 200..<500)
          .responseDecodable(of: Book.self) { response in
                print("status: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    print(value)
                case .failure(let error):
                    print("Failed")
                    print(error)
                }
            }
    }
    
    func callRequestKoGPT() {
        print(#function)
        let url = APIURL.kakaoURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao,
            "Content-Type": "application/json"
        ]
        let para: Parameters = [
            "prompt" : "아미아리마어리ㅏㅇ",
            "max_tokens": 50
        ]
        AF.request(
            url, method: .post,
            parameters: para,
            encoding: JSONEncoding.default, // 💡 파라미터를 json 으로 변경해서 보내겠음
            headers: header
        ).responseString { response in
            print(response)
        }
    }
}
