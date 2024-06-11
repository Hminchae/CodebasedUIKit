//
//  Search.swift
//  MediaApp
//
//  Created by 황민채 on 6/11/24.
//

import Foundation

struct Search: Decodable {
    let page: Int
    var results: [SearchResult]
    let total_pages, total_results: Int
}

struct SearchResult: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path: String?
    let release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
