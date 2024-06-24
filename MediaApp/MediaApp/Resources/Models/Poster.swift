//
//  Poster.swift
//  MediaApp
//
//  Created by 황민채 on 6/25/24.
//

import Foundation

struct Poster: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let posters: [Backdrop]
}

struct Backdrop: Codable {
    let file_path: String
}
