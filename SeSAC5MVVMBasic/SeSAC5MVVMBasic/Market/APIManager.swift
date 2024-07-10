//
//  APIManager.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func fetchUpbitMarketAPI(completionHandler: @escaping (([Market], String) -> Void)) {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
               // print(success)
                let title = success.first?.korean_name ?? "마켓 목록"
               completionHandler(success, title)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
