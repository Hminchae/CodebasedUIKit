//
//  TV.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import Foundation

struct TVListModel: Decodable {
    let page: Int
    let results: [TV]
}

struct TV: Decodable, Hashable {
    let name: String
    let overview: String
    let posterURL: String
    let vote: String
    let firstAirDate: String

    private enum CodingKeys: String, CodingKey {
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)

        let path = try container.decode(String.self, forKey: .posterPath)
        posterURL = "https://image.tmdb.org/t/p/w500\(path)"

        let voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount))"

        firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
    }
}

//struct TVListModel: Codable {
//    let page: Int
//    let results: [TV]
//}
//
//struct TV: Codable {
//    let overview: String
//    let posterPath: String
//    let firstAirDate: String
//    let name: String
//    let voteAverage: Double
//    let voteCount: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case overview
//        case posterPath = "poster_path"
//        case firstAirDate = "first_air_date"
//        case name
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
