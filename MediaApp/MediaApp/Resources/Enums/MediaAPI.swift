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
    
    case movieDetail(movieID: Int)
    case movieSearch(query: String, page: Int)
    case movieDiscover
    case movieSimilar(movieId: Int)
    case movieRecommend(movieId: Int)
    case moviePoster(movieId: Int)
    case movieVideo(movieId: Int)
    
    case youTube(movieKey: String)
    case youTubeThumbnail(movieKey: String)
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPointUrl: String {
        switch self {
        case .trendURL:
            return "trending/movie/day"
        case .creditURL(let id):
            return "movie/\(id)/credits"
        case .imageURL(let path):
            return "https://image.tmdb.org/t/p/original/\(path)"
        case .genreURL:
            return "genre/movie/list"
        case .movieSearch:
            return "search/movie"
        case .movieDiscover:
            return "discover/movie"
        case .movieSimilar(let id):
            return "movie/\(id)/similar"
        case .movieRecommend(let id):
            return "movie/\(id)/recommendations"
        case .moviePoster(let id):
            return "movie/\(id)/images"
        case .movieDetail(let id):
            return "movie/\(id)"
        case .movieVideo(let id):
            return "movie/\(id)/videos"
        case .youTube(let movieKey):
            return "https://www.youtube.com/watch?v=\(movieKey)"
        case .youTubeThumbnail(let movieKey):
            return "https://img.youtube.com/vi/\(movieKey)/hqdefault.jpg"
        }
    }
    
    var entireUrl: String {
        switch self {
        case .imageURL, .youTube, .youTubeThumbnail:
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
        case .creditURL, .movieSimilar, .movieRecommend, .movieDetail:
            return ["language": "ko-KR"]
        default:
            return ["":""]
        }
    }
}
