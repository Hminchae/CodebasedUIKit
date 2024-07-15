//
//  MarketDetailViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/15/24.
//

import UIKit

class MarketDetailViewController: UIViewController {
    
    let viewModel = MarketDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        //navigationItem.title = detail?.korean_name
        //print("??????????????")
        
        viewModel.outputMarketData.bind { market in
            self.navigationItem.title = market?.korean_name
        }
    }
}
