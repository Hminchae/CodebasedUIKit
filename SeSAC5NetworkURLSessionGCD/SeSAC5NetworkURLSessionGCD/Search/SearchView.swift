//
//  SearchView.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 6/25/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    // 뷰컨트롤러 인스턴스 생성 전에 클로저가 먼저 실행이 된다.
    var resultLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "검색 결과가 없습니다."
        print("이이잉 ?")
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(resultLabel)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        searchBar.placeholder = "아무거나 검색해보시던가"
        searchBar.delegate = self
    }
}

extension SearchView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("우웨에에엥엑")
        resultLabel.text = searchBar.text
    }
}
