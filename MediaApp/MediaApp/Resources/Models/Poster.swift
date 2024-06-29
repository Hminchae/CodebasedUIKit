//
//  Poster.swift
//  MediaApp
//
//  Created by 황민채 on 6/25/24.
//

import Foundation

struct Poster: Decodable {
    let backdrops: [PosterBackdrop]
    let id: Int
    let logos: [PosterBackdrop]
}

struct PosterBackdrop: Decodable {
    let file_path: String?
}
