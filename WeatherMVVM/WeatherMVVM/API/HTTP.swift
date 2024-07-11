//
//  HTTP.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/11/24.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
            case apiKey = "appid"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
