//
//  NetworkManager.swift
//  aeWeather
//
//  Created by 황민채 on 6/22/24.
//

import Foundation
import Alamofire

//class NetworkManager {
//    
//    static let shared = NetworkManager()
//    
//    private init() { }
//    
//    func getLotto(_ query: String, completionHandler: @escaping (Int) -> Void) { // static 붙이는게 효율적일까? => 화면이 하나이고, 영영 메모리 공간을 차지하여도 됨(이 함수가 이 앱의 어느정도 비중이냐)
//        let url = APIKey.baseUrl
//        let 
//        AF.request(url).responseDecodable(of: Lotto.self) { response in
//            switch response.result {
//            case .success(let value):
//                print(value.drwNo) // 탈출 클로저
//                print(value.self)
//                
//                completionHandler(value.totSellamnt)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//}
