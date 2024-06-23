//
//  NetworkManager.swift
//  aeWeather
//
//  Created by 황민채 on 6/22/24.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getWeather(lat: Double, lon: Double, completionHandler: @escaping (OpenWeather) -> Void) {
        let url = APIKey.baseUrl
        let para: Parameters = [
            "lat": lat,
            "lon": lon,
            "appid": APIKey.weatherKey,
            "units": "metric"
        ]
        
        AF.request(url, parameters: para).responseDecodable(of: OpenWeather.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
