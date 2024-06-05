//
//  Models.swift
//  MovieBoxOffice
//
//  Created by 황민채 on 6/6/24.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOfficeDetails
}

struct BoxOfficeDetails: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOffice]
}

struct BoxOffice: Decodable {
    let openDt: String
    let movieNm: String
    let rank: String
}
