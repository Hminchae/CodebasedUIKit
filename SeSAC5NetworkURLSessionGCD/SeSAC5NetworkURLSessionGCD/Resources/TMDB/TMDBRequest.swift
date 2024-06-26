//
//  TMDBRequest.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case trendingTV
    case trendingMovie
    case search(query: String)
    case images(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trendingTV:
            return URL(string: baseURL + "trending/tv/day")!
        case .trendingMovie:
            return URL(string: baseURL + "trending/movie/day")!
        case .search:
            return URL(string: baseURL + "search/movie")!
        case .images(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        }
    }
    
    var header: HTTPHeaders {
        ["Authorization": Constants.apiKey,
         "accept": "application/json"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trendingTV, .trendingMovie:
            return ["language": "ko-KR"]
        case .search(let query):
            return ["query": query]
        case .images(let id):
            return ["id": id]
        }
    }
}
