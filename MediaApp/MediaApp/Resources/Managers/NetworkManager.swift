//
//  NetworkManager.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import Foundation

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    // 트렌드 무비
    func trendMovieCallRequest(completionHandler: @escaping (Result<TrendMovie, Error>) -> Void) {
        let url = MediaAPI.trendURL.url
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language" : "ko-KR",
            "time_window" : "week"
        ]
        AF.request(url, method: .get, parameters: para, headers: header).responseDecodable(of: TrendMovie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
               
            }
        }
    }
    
    // 장르 API
    func genreCallRequest(completionHandler: @escaping (Result<Genres, Error>) -> Void) {
        let url = MediaAPI.genreURL.url
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        AF.request(url, headers: header).responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
