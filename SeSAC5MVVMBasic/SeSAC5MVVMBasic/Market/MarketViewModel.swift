//
//  MarketViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

final class MarketViewModel {
    
    let repository = MoneyRepository()
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputCellSelected: Observable<Market?> = Observable(nil)
    // var inputCellIndex: Observable<Int> = Observable(0)
    
    var outputTitleData: Observable<String> = Observable("")
    var outputMarketData: Observable<
        [Market]> = Observable([])
    init() {
        print("MarketViewModel init")
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            print("네트워크 통신 진행")
            self.callRequest()
        }
        
        inputCellSelected.bind { market in
            guard let market = market else { return }
            
            self.saveMarket(
                market: market.market,
                name: market.korean_name,
                won: .random(in: 1...100)
            )
        }
    }
    
    private func saveMarket(
        market: String,
        name: String,
        won: Int
    ) {
        repository.createItem(market: market,
                              name: name,
                              won: won)
    }
    private func callRequest() {
        APIManager.shared.fetchUpbitMarketAPI { market, title  in
            self.outputMarketData.value = market
            self.outputTitleData.value = title
        }
    }
}
