//
//  Genres.swift
//  MediaApp
//
//  Created by 황민채 on 6/11/24.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
