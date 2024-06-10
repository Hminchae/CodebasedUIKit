//
//  ViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//

import UIKit

import Alamofire

class TrendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }

    func callRequest() {
        let url = "\(Constants.baseUrl)/3/movie/popular"
        let header: HTTPHeaders = [
            "Authorization": Constants.apiKey,
            "accept": "application/json"
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: Welcome.self) { response in
            switch response.result {
            case .success(let value):
                print("Success")
                print(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}

