////
////  NetworkManager.swift
////  SeSAC5NetworkURLSessionGCD
////
////  Created by 황민채 on 6/25/24.
////
//
import Foundation

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    typealias trendingnHandler = ([MovieDetail]?, String?) -> Void
    
    func trending<T: Decodable>(api: TMDBRequest, model: T.Type, completionHandler: @escaping (T?, thankyError?) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, .failedRequest)
                
                print(error)
            }
        }
    }
    
//    func moviePoster<T: Decodable>() {
//        print(#function)
//        let url = "https://api.themoviedb.org/3/movie/10300/images"
//        
//        let header: HTTPHeaders = [
//            "Authorization": Constants.apiKey,
//        ]
//        
//        AF.request(url,
//                   method: .get,
//                   headers: header)
//        .validate(statusCode: 200..<500)
//        .responseDecodable(of: T.self) { response in
//            
//            switch response.result {
//            case .success(let value):
//                print("SUCCESS")
//                dump(value)
//            case .failure(let error):
//                print("FAILED")
//                print(error)
//            }
//        }
//    }
//    
//    func movieSearch() {
//        print(#function)
//        let url = "https://api.themoviedb.org/3/search/movie?query=해리포터"
//        
//        let header: HTTPHeaders = [
//            "Authorization": Constants.apiKey,
//        ]
//        
//        AF.request(url,
//                   method: .get,
//                   headers: header)
//        .validate(statusCode: 200..<500)
//        .responseDecodable(of: TrendMovie.self) { response in
//            
//            switch response.result {
//            case .success(let value):
//                print("SUCCESS")
//                dump(value)
//            case .failure(let error):
//                print("FAILED")
//                print(error)
//            }
//        }
//    }
}
