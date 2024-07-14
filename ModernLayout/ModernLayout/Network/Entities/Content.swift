//
//  Content.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import Foundation

struct Content: Decodable, Hashable {
    let title: String
    let overview: String
    let posterURL: String
    let vote: String
    let releaseDate: String
    
    init(tv: TV) {
        self.title = tv.name
        self.overview = tv.overview
        self.posterURL = tv.posterURL
        self.vote = tv.vote
        self.releaseDate = tv.firstAirDate
    }
    
    init(movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.posterURL = movie.posterURL
        self.vote = movie.vote
        self.releaseDate = movie.releaseDate
    }
}
