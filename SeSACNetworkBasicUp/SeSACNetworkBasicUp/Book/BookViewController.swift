//
//  BookViewController.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class BookViewController: UIViewController {
    /*
     페이지네이션
     1. 스크롤이 끝날 쯤에 다음 페이지를 요청 (page += 1 후 callRequest)
     2. 이전 내용은 어떻게 확인하지? -> list 에 append
     3. 다른 검색어를 입력할 때는? == page 가 1일 때
        - 교체가 아니라 append로 되고 있음
        - 1페이지부터 검색되도록 설정
        - 상단으로 스크롤을 이동
     4. 배열을 언제 제거해줄지?
     5. 마지막 페이지 처리
     */
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list = KakaoBook(documents: [],
                        meta: Meta(is_end: false, 
                                   pageable_count: 0,
                                   total_count: 0))
    var page = 1
    var isEnd: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }

    func configureView() {
        print(#function)
        
        searchBar.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.id)
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
  
    func callBookRequest(query: String) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=10"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        print(#function, url)
        AF.request(url, 
                   method: .get, 
                   headers: header)
        .responseDecodable(of: KakaoBook.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.isEnd = value.meta.is_end
                
                if self.page == 1 {
                    self.list = value // 새로운 검색어 
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                } else {
                    self.list.documents.append(contentsOf: value.documents) // 기존 검색어
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }

}

extension BookViewController: UISearchBarDelegate {
    // 무조건 통신이 들어가지 않고,
    // 빈칸, 최소 1자 이상, 같은 글자 등에 대한 처리가 필요할 수 있음
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text else { return }
        callBookRequest(query: text)
    }
}

// ✅ 페이지네이션
extension BookViewController: UITableViewDataSourcePrefetching {
    // cellforRowAt 이 호출되기전에 미리 호출됨
    // 즉, 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    // 호출시점은 애플이 알아서 결정
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Prefetch\(indexPaths)")
        for item in indexPaths {
            if list.documents.count - 2 == item.row && !isEnd {
                page += 1
                callBookRequest(query: searchBar.text!)
            }
        }
    }
    // 취소 기능: 단, 직접 취소하는 기능을 구현 해주어야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath) as! BookTableViewCell
        
        let data = list.documents[indexPath.row]
        cell.titleLabel.text = data.title
        cell.overviewLabel.text = data.contents
        
        let url = URL(string: data.thumbnail)
        cell.thumbnailImageView.kf.setImage(with: url)
        
        return cell
    }
}

extension BookViewController {
    func callRequest() {
        print(#function)
        let url = "\(APIURL.naverURL)query=&display=20&start=1"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverKey,
            "X-Naver-Client-Secret": APIKey.naverKey2
        ]
        AF.request(url, method: .get, headers: header)
          .validate(statusCode: 200..<500)
          .responseDecodable(of: Book.self) { response in
                print("status: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    print(value)
                case .failure(let error):
                    print("Failed")
                    print(error)
                }
            }
    }
    
    func callRequestKoGPT() {
        print(#function)
        let url = APIURL.kakaoURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao,
            "Content-Type": "application/json"
        ]
        let para: Parameters = [
            "prompt" : "아미아리마어리ㅏㅇ",
            "max_tokens": 50
        ]
        AF.request(
            url, method: .post,
            parameters: para,
            encoding: JSONEncoding.default, // 💡 파라미터를 json 으로 변경해서 보내겠음
            headers: header
        ).responseString { response in
            print(response)
        }
    }
}

/* ✅
 1. url
 2. query string
 3. http header - authorization
 4. request
 5. response
 6. (ex. reponseString)
 7. struct
 8. HTTP 상태코드
 */

/* 😱
 1. 식판 오류가 아닌데 왜 식판 오류 문구가 뜰까 ?
 >> 성공했을 때에 대한 식판이라서
 2. success가 실행이 되는걸까 ? failed가 실행이 되는걸까?
 3. success랑 failed 기준이 뭘까?
 >> 상태코드! Almaofire 에서는 200 ~ 300 사이면 성공이라고 판단 -> 문서에 명세
 >> StatusCode / struct
 */



//class BookViewController: UIViewController, RequestAPIFromAFProtocol {
//
//    let searchBar = UISearchBar()
//    let tableView = UITableView()
//    
//    var kakaoBookList = KakaoBook(documents: [], meta: Meta(is_end: false, pageable_count: 0, total_count: 0)) {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    var pastSearchQuery: String = ""
//    var page = 1
//    var isEnd = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureView()
//    }
//    
//    private func configureView() {
//        view.backgroundColor = .systemBackground
//        
//        searchBar.delegate = self
//        
//        tableView.rowHeight = 120
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.prefetchDataSource = self
//        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
//        
//        view.addSubview(searchBar)
//        view.addSubview(tableView)
//        
//        searchBar.snp.makeConstraints { make in
//            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(44)
//        }
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//}
//
//extension BookViewController: UISearchBarDelegate {
//    // 무조건 통신이 들어가지 않고
//    // 빈칸, 최소 1자 이상, 같은 글자 등에 대한 처리가 필요할 수 있음
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // 기존 검색어와 동일하지 않은 지 검사
//        guard let text = searchBar.text, !text.isEmpty, text != pastSearchQuery else { return }
//        
//        // 동일하지 않다면
//        pastSearchQuery = text                 // 기존 검색어를 저장하는 변수에 새 검색어 저장
//        page = 1                               // 페이지도 1로 초기화
//        callRequestKakaoBook(text, page: page) // 해당 데이터를 토대로 API request
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = nil
//    }
//}
//
//extension BookViewController: UITableViewDataSourcePrefetching {
//    
//    // cellForRowAt 보다 먼저 호출됨
//    // 즉, 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운을 받는 기능
//    // 호출 시점은 애플이 알아서 결정해줌
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        print("prefetch", indexPaths)
//        
//        indexPaths.forEach { indexPath in
//            if kakaoBookList.documents.count - 2 == indexPath.row && !isEnd {
//                page += 1
//                if let query = searchBar.text {
//                    callRequestKakaoBook(query, page: page)
//                }
//                print(page)
//            }
//        }
//    }
//    
//    // 취소 기능: 단, 직접 취소하는 기능을 구현을 해주어야 한다.
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        print("cancel", indexPaths)
//        indexPaths.forEach { indexPath in
//            if let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell {
//                cell.thumbnailImageView.kf.cancelDownloadTask()
//            }
//        }
//    }
//}
//
//extension BookViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return kakaoBookList.documents.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
//        let bookDetail = kakaoBookList.documents[indexPath.row]
//        cell.configureContent(bookDetail)
//        return cell
//    }
//}
//
//
//
//extension BookViewController {
////    private func callRequest() {
////        let query = "사랑"
////        let display = 20
////        let start = 1
////        let naverBookURL = "https://openapi.naver.com/v1/search/book.json?query=\(query)&display=\(display)&start=\(start)"
////        let header: HTTPHeaders = [
////            "X-Naver-Client-Id": APIKey.naverClientID,
////            "X-Naver-Client-Secret": APIKey.naverClientSecret
////        ]
////        /*
////         쿼리스트링 값을 빼버렸다
////         1. 식판 오류가 아닌데 왜 식판 오류 문구가 뜰까?
////            - 성공했을 때 오는 JSON 데이터와 실패했을 때 오는 JSON 데이터 형식이 다르기 때문에
////            - 요청에러가 아닌 식판 오류 문구가 출력
////         2. success가 실행이 되는 걸까? failed가 실행이 되는걸까?
////         3. success 랑 failed 기준이 뭘까?
////            - 상태코드(Status Code)를 기준으로 처리를 해준다
////         */
////        requestDecodableCustomTypeResult(urlString: naverBookURL,
////                                         method: .get,
////                                         encoding: URLEncoding.queryString,
////                                         headers: header,
////                                         type: NaverBook.self
////        ) { value in
////            print("SUCCESS")
////            print(value)
////        } failClosure: { error in
////            print("FAILED")
////            print(error)
////        }
////    }
//    
//    private func callRequestKoGPT() {
//        let koGPTUrl = "https://api.kakaobrain.com/v1/inference/kogpt/generation"
//        let header: HTTPHeaders = [
//            "Authorization": APIKey.kakaoKey,
//            "Content-Type": "application/json"
//        ]
//        let parameters: Parameters = [
//            "prompt": "안녕하세요 저는 지금 너무 졸린데 잘 수가 없어요",
//            "max_tokens": 50
//        ]
//        
//        requestStringResult(urlString: koGPTUrl,
//                            method: .post,
//                            parameters: parameters,
//                            encoding: JSONEncoding.default,
//                            headers: header
//        ) { value in
//            print(value)
//        } failClosure: { error in
//            print(error)
//        }
//    }
//    
//    private func callRequestKakaoBook(_ query: String, page: Int) {
//        let url = APIURL.kakaoBookURL
//        let headers: HTTPHeaders = ["Authorization": APIKey.kakaoKey]
//        let parameters: Parameters = [
//            "query": query,
//            "page": page,
//            "size": 50
//        ]
//
//        requestDecodableCustomTypeResult(urlString: url,
//                                         method: .get,
//                                         parameters: parameters,
//                                         encoding: URLEncoding.queryString,
//                                         headers: headers,
//                                         type: KakaoBook.self
//        ) { [weak self] value in
//            guard let self else { return }
//            print(value.meta)
//            isEnd = value.meta.is_end
//            if page > 1 { // 페이지가 1보다 크다면 새 데이터를 배열에 추가
//                kakaoBookList.documents.append(contentsOf: value.documents)
//            } else { // 페이지가 1이라면 새 데이터로 교체
//                kakaoBookList = value
//                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            }
//        } failClosure: { error in
//            print(error)
//        }
//    }
//}
