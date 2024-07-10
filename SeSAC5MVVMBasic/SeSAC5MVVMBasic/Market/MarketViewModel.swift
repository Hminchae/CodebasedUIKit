//
//  MarketViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

import Alamofire

final class MarketViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputTitleData: Observable<String> = Observable("")
    var outputMarketData: Observable<
        [Market]> = Observable([])
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            print("네트워크 통신 진행")
            self.fetchUpbitMarketAPI()
        }
    }
    
    private   func fetchUpbitMarketAPI() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                self.outputMarketData.value = success
                self.outputTitleData.value = success.first?.korean_name ?? "마켓 목록"
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
