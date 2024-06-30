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
    
    var updateUserLocation: ((CLLocation) -> Void)?
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}

extension LocationManager {
    // iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                self.checkCurrentLocationAuthorization()
            } else {
                print("위치 서비스가 꺼져 있어서, 위치 권한을 요청을 할 수 없어요")
            }
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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last {
            updateUserLocation?(coordinate)
            locationManager.stopUpdatingLocation()
        }
    }
    // 위치 업데이트 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    // 권한 상태 변경 iOS14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkDeviceLocationAuthorization()
    }
    // 권한 상태 변경 iOS14-
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14-")
    }
    

    func reverseGeocodeLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("역 지오코딩 실패: \(error)")
                completion("주소를 찾을 수 없습니다.")
            } else if let placemark = placemarks?.first {
                let address = [placemark.locality, placemark.subLocality].compactMap { $0 }.joined(separator: ", ")
                completion(address)  
            } else {
                completion("주소 정보가 없습니다.")
            }
        }
    }
}
