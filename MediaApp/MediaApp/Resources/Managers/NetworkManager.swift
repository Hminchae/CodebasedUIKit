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
    
    // TrendVC - 장르 API
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
    
    // SearchVC - 검색 API
    func searchCallRequest(query: String, page: Int, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        let url = MediaAPI.movieSearch.url
        
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "query": query,
            "language": "ko-KR",
            "page": page
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: para,
                   headers: header)
        .responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // Search Detail VC - 비슷한 영화 API
    func similarCallRequest(id: Int, page: Int, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        let url = MediaAPI.movieSimilar(movieId: id).url
        
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language": "ko-KR"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: para,
                   headers: header)
        .responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // Search Detail VC - 추천 API
    func recommendCallRequest(id: Int, page: Int, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        let url = MediaAPI.movieRecommend(movieId: id).url
        
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language": "ko-KR",
            "page": page
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: para,
                   headers: header)
        .responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func moviePosterCallRequest(id: Int, page: Int, completionHandler: @escaping (Result<Poster, Error>) -> Void) {
        let url = MediaAPI.moviePoster(movieId: id).url
        
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        let para: Parameters = [
            "language": "ko-KR",
            "page": page
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: para,
                   headers: header)
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
