//
//  ViewController.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/17/24.
//

import UIKit

/* ✅
 1. Custom Font
 - 용량: 캭햝뷁 : regular bold italic
 - 저작권 tmi. sf
 - 채팅/댓글/
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var logoLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // 💤 실제 폰트명(패밀리-세부)과 파일명은 다름
        logoLabel.font = UIFont(name: "Yeongdeok-Sea", size: 80)
        for family in UIFont.familyNames {
            print(family)
            for name in UIFont.fontNames(forFamilyName: family) {
                print(">>> \(name)")
            }
        }
        
        // 🔘 버튼
        var configuration = UIButton.Configuration.filled()
        configuration.title = "앗뇽"
        configuration.baseBackgroundColor = .yellow
        configuration.cornerStyle = .large
        testButton.configuration = configuration
    }

}
