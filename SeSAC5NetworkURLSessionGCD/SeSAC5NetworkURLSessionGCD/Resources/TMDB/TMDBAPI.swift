////
////  TMDBAPI.swift
////  SeSAC5NetworkURLSessionGCD
////
////  Created by 황민채 on 6/25/24.
////
//
//import UIKit
//
//class TMDBAPI {
//    static let shared = TMDBAPI()
//    
//    private init() { }
//    
//    // TrendVC - 트렌드 무비
//    func trendMovie(completionHandler: @escaping [MovieDetail]) -> Void) {
//        let url = MediaAPI.trendURL(type: .movie).url
//        let header: HTTPHeaders = [
//            "Authorization": Constants.apiKey,
//            "accept": "application/json"
//        ]
//        let para: Parameters = [
//            "language" : "ko-KR",
//            "time_window" : "week"
//        ]
//        AF.request(url, method: .get, parameters: para, headers: header).responseDecodable(of: TrendMovie.self) { response in
//            switch response.result {
//            case .success(let value):
//                completionHandler(.success(value))
//            case .failure(let error):
//                completionHandler(.failure(error))
//                
//            }
//        }
//    }
//}
