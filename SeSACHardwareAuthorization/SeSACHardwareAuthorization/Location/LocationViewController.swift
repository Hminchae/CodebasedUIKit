//
//  LocationViewController.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/19/24.
//

import UIKit
import CoreLocation // 1️⃣ 위치 프레임워크 임포트
import MapKit
import SnapKit

/* 📚 Enum
 - case
 - rawValue
 - CaseIterable
 
 - < 겨울왕국 > 인투디언논 ~~
 - @unknown: 추후에 미래 버전에 멤버(case)가 추가될 가능성이 있는 열거형
  => 🫠 Unfrozen Enumeration
 - @frozen
  => 🥶 Frozen Enumeration
 
 */
class LocationViewController: UIViewController {
    
    let locationButton = UIButton()
    let mapView = MKMapView()
    
    // 2️⃣ 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager() // 📕 인스턴스 메서드와 프로퍼티만 접근 가능함
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        // 4️⃣ 클래스와 delegate 연결
        locationManager.delegate = self
    }
    
    func configureUI() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        view.backgroundColor = .white
        view.addSubview(locationButton)
        
        locationButton.backgroundColor = .red
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
    }
    
    @objc func locationButtonClicked() {
        print(#function)
        // 권한 요청 문구 띄우기
        // 항상띄워지지는 않음. '처음' 기준은?
        // iphone 위치 서비스
        // 🤷‍♀️ notDetemined 상태일 때!
        
        // 💡1️⃣ 사용자에게 권한 요청을 하기위해, iOS 위치 서비스 활성화 여부 체크
        // 💡2️⃣ 현재 사용자 위치 권한 상태 확인
        // 💡3️⃣ notDetermined일 때 권한을 요청
        
        checkDeviceLocationAuthorization() // 인스턴스가 생성이 될 때 authrization 코드가 호출이 됨, 그래서 viewDidLoad 에 작성하지 않아도 X
    }
}

extension LocationViewController {
    // 💡1️⃣ 사용자에게 권한 요청을 하기위해, iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() { // 📕 타입메서드와 타입프로퍼티에 접근 가능함
            checkCurrentLocationAuthorization()
        } else {
            print("위치 서비스가 꺼져 있어서, 위치 권한을 요청을 할 수 없어요")
        }
    }
    // 💡2️⃣ 현재 사용자 위치 권한 상태 확인
    func checkCurrentLocationAuthorization() {
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print("이 권한에서만 권한 문구를 띄워줄 수 있음")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest// ⏳ 업데이트 주기
            locationManager.requestWhenInUseAuthorization()
        
        case .denied:
            print("iOS 설정 창으로 이동하라는 얼럿을 띄워줘")
        case .authorizedWhenInUse:
            print("위치 정보 알려달라고 로직을 구성할 수 있음")
            locationManager.startUpdatingLocation() //
        default:// 🚨 업데이트에 대응
            print(status)
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        // 📍 맵뷰, 맵뷰에 어노테이션
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
}
// 3️⃣ 위치 관련 프로토콜 선언 : CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate {
    // 5️⃣ 사용자 위치를 성공적으로 가지고 온 경우
    // 코드 구성에 따라 여러번 호출이 될 수 도 있다
    // didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            print(coordinate.latitude)
            print(coordinate.longitude)
            
            setRegionAndAnnotation(center: coordinate)
        }

        // -> 📢 startUpdatingLocation을 했으면 더이상 위치를 안 받아도 되는 시점에서는 stop 을 외쳐야 함
        locationManager.stopUpdatingLocation()
    }
    // 6️⃣ 사용자 위치를 가지고 오지 못했거나
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    // 7️⃣ 사용자 권한 상태가 변경이 될 때(iOSS14)
    // 사용자가 허용했었는데 아이폰 설정에서 나중에 허용을 거부한다면..
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkDeviceLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14-")
    }
}
