//
//  MarketViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

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
            self.callRequest()
        }
    }
    
    private func callRequest() {
        APIManager.shared.fetchUpbitMarketAPI { market, title  in
            self.outputMarketData.value = market
            self.outputTitleData.value = title
        }
    }
}
