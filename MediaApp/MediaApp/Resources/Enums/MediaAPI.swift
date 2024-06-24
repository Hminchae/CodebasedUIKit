//
//  MediaAPI.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//

import Foundation

enum MediaAPI {
    case trendURL
    case creditURL(movieId: Int)
    case imageURL(imagePath: String)
    case genreURL
    case movieSearch
    case movieDiscover
    
    var url: String {
        switch self {
        case .trendURL:
            return "https://api.themoviedb.org/3/trending/movie/day"
        case .creditURL(let id):
            return "https://api.themoviedb.org/3/movie/\(id)/credits"
        case .imageURL(let path):
            return "https://image.tmdb.org/t/p/original/\(path)"
        case .genreURL:
            return "https://api.themoviedb.org/3/genre/movie/list"
        case .movieSearch:
            return "https://api.themoviedb.org/3/search/movie"
        case .movieDiscover:
            return "https://api.themoviedb.org/3/discover/movie"
        }
    }
}
