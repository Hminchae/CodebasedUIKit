//
//  Trend.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import Foundation

struct TrendMovie: Decodable {
    let page: Int
    let results: [MovieDetail]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieDetail: Decodable {
    let id: Int
    let poster_path: String
}


enum MediaType: String, Decodable {
    case movie = "movie"
    case tv = "tv"
}

enum MediaAPI {
    case trendURL(type: MediaType)
    case imageURL(imagePath: String)
    
    var url: String {
        switch self {
        case .trendURL(let type):
            return "https://api.themoviedb.org/3/trending/\(type)/day"
        case .imageURL(let path):
            return "https://image.tmdb.org/t/p/original/\(path)"
        }
    }
}
