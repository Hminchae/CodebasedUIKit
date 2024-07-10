//
//  Endpoint.swift
//  iCrypto
//
//  Created by 황민채 on 7/11/24.
//

import Foundation

enum Endpoint {
    
    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
    case postConins(url: String = "/v1/postCoins")// <- 이런식으로 추가하면 endpoint 관리하기 쉽다고
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme // Https
        components.host = Constants.baseURL
        components.port = Constants.port // example.com:5500
        components.path = self.path // /v1/cryptocurrency/listings/latest
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
            
        case .fetchCoins(url: let url),
                .postConins(url: let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "CAD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
        case .postConins(url: let url):
            return []
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        case .postConins:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchCoins:
            return nil
        case .postConins:
            return nil
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
        case .postConins:
            return
        }
    }
}
