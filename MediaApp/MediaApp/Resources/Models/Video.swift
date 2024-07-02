//
//  Video.swift
//  MediaApp
//
//  Created by 황민채 on 7/2/24.
//

import Foundation

struct Video: Decodable {
    let id: Int
    let results: [VideoDetail]
}

struct VideoDetail: Decodable {
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let published_at: String
    let id: String
}
