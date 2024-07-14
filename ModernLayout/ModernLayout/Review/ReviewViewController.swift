//
//  ReviewViewController.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit
import RxSwift

class ReviewViewController: UIViewController {
    
    let viewModel: ReviewViewModel
    let disposeBag = DisposeBag()
    
    init(id: Int, contentType: ContentType) {
        self.viewModel = ReviewViewModel(id: id, contentType: contentType)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        print(id, contentType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: ReviewViewModel.Input())
        
        output.reviewResult.bind { result in
            switch result {
            case .success(let reviewList):
                print(reviewList)
            case .failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
