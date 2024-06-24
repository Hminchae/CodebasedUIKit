//
//  LottoManager.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/24/24.
//

import Foundation

import Alamofire

class LottoManager {
    private init() { }
    
    static func callRequest(number: String, completionHandler: @escaping (String) -> Void)  {
        let url = "\(APIURL.lottoURL)\(number)"

        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler("\(value.drwNoDate)\n1등 당첨금액: \(value.totSellamnt.formatted())")
            case .failure(let error):
                print(error)
                completionHandler("올바른 값을 입력해주세요.")
            }
        }
    }
}
