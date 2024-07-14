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
    private let contentID: Int
    private let contentType: ContentType
    init(contentID: Int, contentType: ContentType) {
        self.contentID = contentID
        self.contentType = contentType
        let provider = NetworkProvider()
        reviewNetwork = provider.makeReviewNetwork()
    }
    struct Input {
    }
    
    struct Output {
        let reviewResult: Observable<Result<[ReviewModel], Error>>
    }
    
    func transform(input: Input) -> Output {

        let reviewResult: Observable<Result<[ReviewModel], Error>> = reviewNetwork.getReviewList(id: contentID, contentType: contentType)
            .map { reviewResult in
            return .success(reviewResult.results)
        }.catch { error in
            return Observable.just(.failure(error))
        }
        return Output(reviewResult: reviewResult)

    }
}
