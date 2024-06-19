//
//  ViewController.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/17/24.
//

/*
 CLLocation+Mapkit
 Class/Struct
 Typecasting
 Do-Try Catch / Error Handling
 Decodable
 
 */
import UIKit

/* ✅
 1. Custom Font
 - 용량: 캭햝뷁 : regular bold italic
 - 저작권 tmi. sf
 - 채팅/댓글 vs 네비게이션
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var swiftButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var logoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 💤 실제 폰트명(패밀리-세부)과 파일명은 다름
        logoLabel.font = UIFont(name: "Yeongdeok-Sea", size: 80)
//        for family in UIFont.familyNames {
//            print(family)
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(">>> \(name)")
//            }
//        }
        
        // 🔘 버튼의 구조체 자체를 변경하는 방법
        /*
         var configuration = UIButton.Configuration.filled()
         configuration.title = "앗뇽"
         //configuration.baseBackgroundColor = .yellow
         configuration.subtitle = "앗뇽이란 안녕의 다른말.."
         configuration.cornerStyle = .large
         configuration.baseForegroundColor = .label
         configuration.image = UIImage(systemName: "airpod.gen3.right")
         configuration.imagePlacement = .trailing
         */
        
        // ✏️ UIButton.configuration+Extension
        testButton.configuration = .blackStyle()
        testButton.addTarget(self, action: #selector(testButtonClicked), for: .touchUpInside)
        swiftButton.addTarget(self, action: #selector(swiftButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func testButtonClicked(_ sender: UIButton) {
        //🔔
        // 1. 콘텐츠
        let content = UNMutableNotificationContent()
        content.title = "포포포?"
        content.subtitle = "백그라운드에서만 알림이 오는게 디폴트입니당"
        content.badge = (Int.random(in: 1...100)) as NSNumber
        // 2. 언제
        //  1) 시간간격
        //  2) 캘린더 기반
        //  3) 위치 기반
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // 최소 60초 이상 반복 가능
        // 3. iOS 알림센터 시스템에 등록
        let request = UNNotificationRequest(
            identifier: "\(Date())", // 알림 고유값 기준으로 쌓임!, 그래서 "\(Date())" 식으로 하곤 함
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    @objc func swiftButtonClicked() {
        let vc = LocationViewController()
        present(vc, animated: true)
    }

}


/*
 🚨 Notification 관련 정책
 - identifier: 고유값 / 64개까지만
 - TimeInterval: 60초 이상이어야 반복 가능
 - foreground 에서는 알림을 뜨지 않는 것이 default
 - Foreground 에서 알림을 받고 싶다면 별도 설정(delegate)필요
 - 알림센터에 보이고 있는지, 사용자에게 전달되었는지 알 수 없음
 - 단, 사용자가 알림을 '클릭'했을 때만 확인 가능(delegate)
 */
