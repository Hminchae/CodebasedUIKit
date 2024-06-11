//
//  Book.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/10/24.
//

import Foundation

struct Book: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [BookInfo]
}

struct BookInfo: Decodable {
    let title: String
    let link: String
    let image: String
    let author: String
    let discount: String
    let publisher: String
    let pubdate: String
    let isbn: String
    let description: String
}

/*
 https://quicktype.io/ : 구조체 정리하기 귀찮을때 사용할 수 있음
 */

