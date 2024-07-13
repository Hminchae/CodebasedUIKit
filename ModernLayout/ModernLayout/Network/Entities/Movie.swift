//
//  Movie.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let name: String
    let overview: String
    let posterURL: String
    let vote: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case overview
        case posterPath
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)
        
        let path = try container.decode(String.self, forKey: .posterPath)
        posterURL = "https://api.themoviedb.org/3/\(path)"
        
        let voteAverage = try container.decode(String.self, forKey: .voteAverage)
        let voteCount = try container.decode(String.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount)"
        
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}
