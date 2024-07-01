//
//  NasaViewController.swift
//  SeSAC5NetworkURLSessionGCD
//
//  Created by 황민채 on 7/1/24.
//

import UIKit

class NasaViewController: BaseViewController {
    
    enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
         
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
    let nasaImageView = UIImageView()
    let progressLabel = UILabel()
    let requestButton = UIButton()
    
    var total: Double = 0 // 이미지의 총 크기
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100) / 100"
        }
    }
    
    // 화면 전환을 했거나, 앱을 종료하거나 등 뷰가 사라지는 시점에 네트워크와 관련된 리소스 정리가 필요
    // 카톡에서 이미지도 많이 다운받고 있는데, 다른 톡방을 켰다면??
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 화면이 사라진다면 네트워크 통신도 바로 함께 중단
        // ⬇️다운로드 중인 리소스도 무시
        session.invalidateAndCancel()
        
        // ⬇️다운로드가 완료될 때까지 기다렸다가, 다운로드가 완료되면 리소스 정리
        session.finishTasksAndInvalidate()
    }
    
    override func configureHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressLabel)
        view.addSubview(requestButton)
    }
    
    override func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    override func configureView() {
        requestButton.backgroundColor = .systemBlue
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
        
        progressLabel.textColor = .label
        progressLabel.font = .boldSystemFont(ofSize: 25)
    }
    
    // 1. configuration : default
    private func callRequest() {
        buffer = Data()
        
        let request = URLRequest(url: Nasa.photo)
        
        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: request).resume()
    }
    
    @objc private func requestButtonClicked() {
        callRequest()
    }
}

// Task의 종류에 따라 만들어져 있는 프로토콜이 여러가지 있음..
// Websocket..등
extension NasaViewController: URLSessionDataDelegate {
    // 서버에서 최초로 응답 받은 경우에 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(#function, response)
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode) {
            
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            
            total = Double(contentLength)!
            
            progressLabel.text = String(total)
            
            return .allow
        } else {
            return .cancel
        }
    }
    // 서버에서 데이터를 받아올 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function, data)
        
        buffer?.append(data)
        
        //progressLabel.text = "\(total) 중 \(buffer)"
    }
    // 응답이 완료될 때 호출됨
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(#function, error)
        if let error = error {
            progressLabel.text = "문제가 발생했습니다."
        } else {
            print("성공") // completionHandler 호출 시점과 동일
            
            guard let buffer = buffer else {
                print("Buffer is nil")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
}
