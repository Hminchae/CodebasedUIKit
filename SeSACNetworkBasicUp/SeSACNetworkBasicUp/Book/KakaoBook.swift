//
//  KakaoBook.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/11/24.
//

import Foundation

struct KakaoBook: Decodable {
    var documents: [BookDetil]
    let meta: Meta
}

struct Meta: Decodable {
    let is_end: Bool
    let pageable_count: Int
    let total_count: Int
}

struct BookDetil: Decodable {
    let title: String
    let contents: String
    let url: String
    let thumbnail: String
    let authors: [String]
    
    let price: Int
    let publisher: String
    let sale_price: Int
    let translators: [String]
}
