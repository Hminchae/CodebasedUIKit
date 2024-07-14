//
//  Network.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class Network<T: Decodable> {

    private let endpoint: String
    private let queue: ConcurrentDispatchQueueScheduler
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    func getItemList(path: String, language: String = "ko-KR") -> Observable<T> {
        let fullPath = "\(endpoint)\(path)?language=\(language)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constant.key)",
            "accept": "application/json"
        ]
        
        print(fullPath)
        
        return RxAlamofire.request(.get, fullPath, headers: headers)
            .observe(on: queue)
            .debug()
            .data()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}
