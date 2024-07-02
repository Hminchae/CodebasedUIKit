//
//  YouTubePlayViewController.swift
//  MediaApp
//
//  Created by 황민채 on 7/2/24.
//

import UIKit

import WebKit

final class YouTubePlayViewController: BaseViewController {
    
    var link: String?
    var productTitle: String?
    var isBasketClicked: Bool?
    var productId: String?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let link = link, let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view)
        }
        
    }
}
