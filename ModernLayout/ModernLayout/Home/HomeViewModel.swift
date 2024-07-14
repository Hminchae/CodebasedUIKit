//
//  HomeViewModel.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    let disposeBag = DisposeBag()
    
    private let tvNetwork: TVNetwork
    private let movieNetwork: MovieNetwork
    
    init() {
        let provider = NetworkProvider()
        tvNetwork = provider.makeTVNetwork()
        movieNetwork = provider.makeMovieNetwork()
    }
    
    struct Input { // VC 에서 받아지는 어떤 이벤트들
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    struct Output { // 받아와지는 결과값들
        let tvList: Observable<[TV]>
        let movieList: Observable<Result<MovieResult, Error>>
    }
    
    func transform(input: Input) -> Output {
        
        // trigger 발동 => 네트워크 시도 -> 네트워크가 return 하는 Observable<T> -> VC 전달 -> VC 에서 구독
        
        // tvTrigger -> Observable<Void> -> Observable<[TV]>
        let tvList = input.tvTrigger.flatMapLatest { [unowned self] _ -> Observable<[TV]> in
            // Observable<TVListModel> -> Observable<[TV]>
            return self.tvNetwork.getTopRatedList().map{ $0.results }
        }
        
        let movieList = input.movieTrigger.flatMapLatest { [unowned self] _ -> Observable<Result<MovieResult, Error>> in
            // combineLatest -> 결과값 합치기
            // Observable 1,2,3 합쳐서 하나의 Observable 로 바꾸고 싶다면?
            return Observable.combineLatest(self.movieNetwork.getUpcomingList(), self.movieNetwork.getPopularList(), self.movieNetwork.getNowPlayingList()) { upcoming, popular, nowPlaying -> Result<MovieResult, Error> in
                
                //return MovieResult(upcoming: upcoming, popular: popular, nowPlaying: nowPlaying)
                    .success(MovieResult(upcoming: upcoming, popular: popular, nowPlaying: nowPlaying))
            }.catch { error in
                print(error)
                return Observable.just(.failure(error))
            }
        }
        return Output(tvList: tvList, movieList: movieList)
    }
}
