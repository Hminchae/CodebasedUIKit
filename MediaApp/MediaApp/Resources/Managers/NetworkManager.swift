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
    
    // TrendVC - 트렌드 무비
    func trendMovieCallRequest(api: MediaAPI, completionHandler: @escaping (Result<TrendMovie, Error>) -> Void) {
    
        AF.request(api.entireUrl,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .responseDecodable(of: TrendMovie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
               
            }
        }
    }
    
    // TrendVC - 장르 API
    func genreCallRequest(api: MediaAPI, completionHandler: @escaping (Result<Genres, Error>) -> Void) {
    
        AF.request(api.entireUrl,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
            .responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // SearchVC - 검색 API, 비슷한 영화 API, 추천 API, 비슷한 영화 API, 추천 API
    func searchCallRequest(api: MediaAPI, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        
        AF.request(api.entireUrl,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func moviePosterCallRequest(api: MediaAPI, id: Int, page: Int, completionHandler: @escaping (Result<Poster, Error>) -> Void) {
    
        AF.request(api.entireUrl,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
