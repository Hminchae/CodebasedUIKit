//
//  LocationManager.swift
//  aeWeather
//
//  Created by 황민채 on 6/23/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    var updateUserLocation: ((CLLocationCoordinate2D) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}

extension LocationManager {
    // iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        } else {
            print("위치 서비스가 꺼져 있어서, 위치 권한을 요청을 할 수 없어요")
        }
    }
    // 현재 사용자 위치 권한 상태 확인
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
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 업데이트 주기
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("iOS 설정 창으로 이동하라는 얼럿을 띄워줘")
        case .authorizedWhenInUse:
            print("위치 정보 알려달라고 로직을 구성할 수 있음")
            locationManager.startUpdatingLocation()
        default: // 업데이트에 대응
            print(status)
        }
    }
}

// 위치 관련 프로토콜 선언 : CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    // 5️⃣ 사용자 위치를 성공적으로 가지고 온 경우
    // 코드 구성에 따라 여러번 호출이 될 수 도 있다
    // didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            updateUserLocation?(coordinate)
            locationManager.stopUpdatingLocation()
        }
    }
    // 사용자 위치를 가지고 오지 못했음
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    // 사용자 권한 상태가 변경이 될 때(iOSS14)
    // 사용자가 허용했었는데 아이폰 설정에서 나중에 허용을 거부한다면..
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14-")
    }
}
