//
//  ReviewViewModel.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import Foundation
import RxSwift

final class ReviewViewModel {
    
    private let reviewNetwork: ReviewNetwork
    private let id: Int, contentType: ContentType
    
    init(id: Int, contentType: ContentType) {
        let provider = NetworkProvider()
        self.reviewNetwork = provider.makeReviewNetwork()
        self.id = id
        self.contentType = contentType
    }
    
    struct Input { // vc 가 생성되자 마자 네트워크 인스턴스가 생성되기 때문에 딱히 input 에 대한 trigger 가 필요하지 않을 듯
        
    }
    
    struct Output {
        let reviewResult: Observable<Result<[ReviewModel], Error>>
        
    }
    
    func transform(input: Input) -> Output {
        
        let reviewResult: Observable<Result<[ReviewModel], Error>> = reviewNetwork.getReviewList(id: id, contentType: contentType).map { reviewResult in
            return .success(reviewResult.results)
        }.catch { error in
            return Observable.just(.failure(error))
        }
        return Output(reviewResult: reviewResult)
    }
}
