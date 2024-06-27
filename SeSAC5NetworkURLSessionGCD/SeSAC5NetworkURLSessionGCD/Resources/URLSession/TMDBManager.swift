//
//  TMDBManager.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/26/24.
//

import Foundation

struct Lotto: Decodable {
    let drwNoDate: String
    //let totSellament: String
}
enum thankyError: Error {
    case failedRequest
    case noData
    case invalidResponsse
    case invalidData
}

class TMDBManager {
    static let shared = TMDBManager()
    
    private init() { }
    
    func callRequest(completionHandler: @escaping (Lotto?, thankyError?) -> Void) {

        let url = URL(string: "https://www.dhloddttery.co.kr/common.do?method=getLottoNumber&drwNo=1100")!
       let request = URLRequest(url: url,
                   timeoutInterval: 5)
        
        // Url / URLRequest / URL Component
        var component = URLComponents()
        component.scheme = "Https"
        component.host = "www.dhlottery.co.kr"
        component.path = "/common.do"
        component.queryItems = [
            URLQueryItem(name: "method", value: "getLottoNumber"),
            URLQueryItem(name: "drwNo", value: "1100")
        ]
        if let url = component.url {
            let request = URLRequest(url: url, timeoutInterval: 5)
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                DispatchQueue.main.async { //⬅️ 🤔 !! 🥳 이렇게도 가능하다.
                    guard error == nil else {
                        print("Failed Request")
                        completionHandler(nil, .failedRequest)
                        return
                    }
                    
                    guard let data = data else {
                        print("No Data Returned")
                        completionHandler(nil, .noData)
                        return
                    }
                    
                    // error가 nil 인 상황, data가 있는 상황
                    
                    guard let response = response as? HTTPURLResponse else {
                        completionHandler(nil, .invalidResponsse)
                        print("Unable Response")
                        return
                    }
                    
                    guard response.statusCode == 200 else {
                        print("failed Response")
                        completionHandler(nil, .failedRequest)
                        return
                    }
                    
                    print("이제 식판에 담으면 돼! 🍱")
                    
                    do {
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        completionHandler(result, nil)
                        print(result)
                        print("Success")
                        
                    } catch {
                        print("Error")
                        print(error)
                        completionHandler(nil, .invalidData)
                    }
                }
            }.resume()
        }
    }
}
