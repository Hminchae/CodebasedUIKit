//
//  TMDBManager.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/26/24.
//

import Foundation

class TMDBManager {
    static let shared = TMDBManager()
    
    private init() { }
    
    func callRequest() {
        print("네트워크 요청 ~~~~~")
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1100")!
       let request = URLRequest(url: url,
                   timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺")
            print(data)
            print("💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺")
            print(response)
            print("💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺💃🕺")
            print(error)
        }.resume()
    }
}
