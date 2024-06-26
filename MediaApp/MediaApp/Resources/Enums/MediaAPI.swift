//
//  MediaAPI.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//

import Foundation

import Alamofire

enum MediaAPI {
    case trendURL
    case creditURL(movieId: Int)
    case imageURL(imagePath: String)
    case genreURL
    
    case movieSearch(query: String, page: Int)
    case movieDiscover
    case movieSimilar(movieId: Int)
    case movieRecommend(movieId: Int)
    case moviePoster(movieId: Int)
    
    var baseUrl: String {
        return "https://api.themoviedb.org/"
    }
    
    var endPointUrl: String {
        switch self {
        case .trendURL:
            return "3/trending/movie/day"
        case .creditURL(let id):
            return "3/movie/\(id)/credits"
        case .imageURL(let path):
            return "https://image.tmdb.org/t/p/original/\(path)"
        case .genreURL:
            return "3/genre/movie/list"
        case .movieSearch:
            return "3/search/movie"
        case .movieDiscover:
            return "3/discover/movie"
        case .movieSimilar(let id):
            return "3/movie/\(id)/similar"
        case .movieRecommend(let id):
            return "3/movie/\(id)/recommendations"
        case .moviePoster(let id):
            return "3/movie/\(id)/images"
        }
    }
    
    var entireUrl: String {
        switch self {
        case .imageURL:
            return endPointUrl
        default:
            return baseUrl + endPointUrl
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
        case .trendURL:
            return ["language": "ko-KR", "time_window" : "week"]
        case .movieSearch(let query, let page):
            return ["query": query, "language": "ko-KR", "page": page]
        case .creditURL, .movieSimilar, .movieRecommend, .moviePoster:
            return ["language": "ko-KR"]
        default:
            return ["":""]
        }
    }
}
