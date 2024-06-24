//
//  NASAViewController.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/20/24.
//

import UIKit

import SnapKit

class NASAViewController: UIViewController {
    
    let callButton = UIButton()
    let testSwitch = UISwitch() // 에약어에 `var` 이런식으로 사용도 가능함
    let oneImageView = UIImageView()
    let twoImageView = UIImageView()
    let threeImageView = UIImageView()
    let fourImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        print("1")
        
        DispatchQueue.main.async {
            print("2")
        }
        
        print("3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
    }
    
    func configureUI() {
        view.addSubview(callButton)
        view.addSubview(testSwitch)
        view.addSubview(oneImageView)
        view.addSubview(twoImageView)
        view.addSubview(threeImageView)
        view.addSubview(fourImageView)
        
        callButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        testSwitch.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(callButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        oneImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(100)
            make.top.equalTo(testSwitch.snp.bottom).offset(20)
        }
        
        twoImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(100)
            make.top.equalTo(oneImageView.snp.bottom).offset(20)
        }
        
        threeImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(100)
            make.top.equalTo(twoImageView.snp.bottom).offset(20)
        }
        
        fourImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(100)
            make.top.equalTo(threeImageView.snp.bottom).offset(20)
        }
        
        callButton.backgroundColor = .red
        testSwitch.onTintColor = .orange
        oneImageView.backgroundColor = .yellow
        twoImageView.backgroundColor = .green
        threeImageView.backgroundColor = .systemBlue
        fourImageView.backgroundColor = .purple
        
        callButton.addTarget(self, action: #selector(callButtonClicked), for: .touchUpInside)
    }
    
    // ✅ 스위치나 화면전환처럼 바로 즉각적인 반응을 할 수 있도록 닭벼슬이 가지고 있던 일을 다른 알바생한테 보내놓고, 닭벼슬(main)은 자기 할일들을 함
    @objc func callButtonClicked() {
        print("START", Thread.isMainThread)
        // 1️⃣ 동기로 이미지를 다운로드 받는 상황
        //        syncDownloadImage(oneImageView, value: "One")
        //        syncDownloadImage(twoImageView, value: "Two")
        //        syncDownloadImage(threeImageView, value: "Three")
        //        syncDownloadImage(fourImageView, value: "Four")
        // 2️⃣ 비동기로 이미지를 다운로드 받는 상황
        // 일단 global을 만나면 다른 알바생에게 작업을 보냄
        // 나머지 코드들은 바로 실행
        // 아쉬운 점은, 다른 알바생들의 작업이 언제 완료되는지 명확한 시점을 알수없다
        // 누가 먼저 끝날지도 알 수 없다.
        //        asyncDownloadImage(oneImageView, value: "One")
        //        asyncDownloadImage(twoImageView, value: "Two")
        //        asyncDownloadImage(threeImageView, value: "Three")
        //        asyncDownloadImage(fourImageView, value: "Four")
        concurrentAsync()
        print("END", Thread.isMainThread)
    }
    
    func asyncDownloadImage(_ imageView: UIImageView, value: String) {
        print("====\(value)-1", Thread.isMainThread)
        
        DispatchQueue.global().async {
            print("====\(value)-2", Thread.isMainThread)
            do {
                print("====\(value)-3", Thread.isMainThread)
                let data = try Data(contentsOf: Nasa.photo) // 🤦 허점 : 이미지 캐싱 X
                print("====\(value)-4", Thread.isMainThread)
                DispatchQueue.main.async {
                    print("====\(value)-5", Thread.isMainThread)
                    imageView.image = UIImage(data: data)
                    print("====\(value)-6", Thread.isMainThread)
                }
                print("====\(value)-7", Thread.isMainThread)
            } catch {
                imageView.image = UIImage(systemName: "star")
            }
        }
        print("====\(value)-8", Thread.isMainThread)
    }
    
    func syncDownloadImage(_ imageView: UIImageView, value: String) {
        print("====\(value)-1")
        do {
            print("====\(value)-2")
            let data = try Data(contentsOf: Nasa.photo) // 🤦 허점 : 이미지 캐싱 X
            print("====\(value)-3")
            imageView.image = UIImage(data: data)
            print("====\(value)-4")
        } catch {
            imageView.image = UIImage(systemName: "star")
        }
        print("====\(value)-5")
    }
    
    func concurrentAsync() {
        print("START", terminator: " 😵 ")
        
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator:  " ❤️ ")
            }
        }
        
        DispatchQueue.global().async {
            for i in 101...200 {
                print(i, terminator:  " 🧡 ")
            }
        }
        DispatchQueue.global().async {
            for i in 201...300 {
                print(i, terminator:  " 💛 ")
            }
        }
        DispatchQueue.global().async {
            for i in 301...400 {
                print(i, terminator:  " 💚 ")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            for i in 401...500 {
                print(i, terminator:  " 🩵 ")
            }
        }
        print("END", terminator: " 💙 ")
        
    }
    // ☄️ 다른 알바생에게 일을 동기적으로 보내는 상황
    // 하지만 닭벼슬은 다른 알바생 일이 끝날 때까지 기다렸다가 다음 일을 진행
    // 즉, 메인스레드에서 동작하는 것과 유사하기 때문에 실질적으로 메인스레드에서 작업을 수행하게 되는것이라서 이 코드는 잘 사용하지 않는다.
    func concurrentSync() {
        print("START", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator:  " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator:  " ")
        }
        
        print("END", terminator: " ")
    }
    
    func serialAsync() {
        print("START", terminator: " ")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator:  " ")
            }
            
            // 😵 LayoutSubview 에서 Radius 적용해주어야 했던 문제도 async 구문에서 써주면 해결이 됨
        }
        
        for i in 101...200 {
            print(i, terminator:  " ")
        }
        
        print("END", terminator: " ")
    }
    
    func serialSync() {
        print("START", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator:  " ")
        }
        
        DispatchQueue.main.sync { // 💥 터지는 이유 :  도르마무, 서로서로 일을 보내고 기다리는 상태 -> 무한 대기 상태, 교착상태, DeadLock
            for i in 101...200 {
                print(i, terminator:  " ")
            }
        }
        
        print("END", terminator: " ")
    }
    
    func GCDBasic() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2406/AraDragons_Taylor_4728.jpg")!
        DispatchQueue.global().async { // 다른 알바생에게 일을 분배 => 😭 단, 다른 알바생에게 보낸 작업이 언제 끝나는 지 정확한 시점을 알기가 어려워짐.
            do {
                // 이미지 다운 받는 시간동안 어떤 작업도 할 수 없음
                // 코드는 기본적으로 순서대로 실행되기 때문  = > 동기
                let data = try Data(contentsOf: url) //동기적으로 작동하는것으로 만들어진 코드이기 때문에  다른 알바생에게 맡겨야만 함
                DispatchQueue.main.async { // 다시 닭벼슬에게 화면에 관련한 일을 맡기기
                    // UI와 관련된 작업은 항상 메인 쓰레드에서 진행을 하여야만 함
                    self.oneImageView.image = UIImage(data: data) // 오ㅐ self? 👀
                }
            } catch {
                self.oneImageView.image = UIImage(systemName: "star.fill")
            }
        }
    }
}
