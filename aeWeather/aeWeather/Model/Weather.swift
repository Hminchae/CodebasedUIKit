//
//  Weather.swift
//  aeWeather
//
//  Created by 황민채 on 6/23/24.
//

import Foundation

struct OpenWeather: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let id: Int
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Sys: Decodable {
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Decodable {
    let main: String // ex) "Clear"
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
