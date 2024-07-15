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
    var outputCellSelected: Observable<Market?> = Observable(nil)
    
    var outputTitleData: Observable<String> = Observable("")
    var outputMarketData: Observable<[Market]> = Observable([])
    
    init() {
        print("MarketViewModel init")
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            print("네트워크 통신 진행")
            self.callRequest()
        }
        
        inputCellSelected.bind { [weak self] market in
                    guard let self = self, let market = market else { return }
                    print("Cell selected: \(market)")
                    self.outputCellSelected.value = market // 인풋이 들어오면 아웃풋에 market 을 내보내라
            
//            self.saveMarket(
//                market: market.market,
//                name: market.korean_name,
//                won: .random(in: 1...100)
//            )
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
