//
//  ClosureViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/11/24.
//

import UIKit

class ClosureViewController: UIViewController {
    
    // 1. 함수를 클로저로 변경해서 상수에 담기
    func hello(name: String, age: Int) { // function type () -> Void
        let des = "\(name)은 \(age)살"
        print(des)
    }
    // 1️⃣
    let a: () -> Void = {
        let des = "~~"
        print(des)
    }
    
    // 2️⃣
    let b: (String, Int) -> Void = { name, age in
        let des = "\(name)은 \(age)입니다."
        print(des)
    }
    
    // 💡
    let c = { (name: String, age: Int) -> Void in
        let des = "\(name)은 \(age)입니다."
        print(des)
    }
    
    // 2. 클로저를 변경해서 함수로 만들기
    let today = { date in
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        
        return format.string(from: date)
    }(Date())
    
    func dateFormat(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        
        return format.string(from: date)
    }
    
    func todayNumber(random: Int) {
        print(random)
    }
    
    let random: (Int) -> Void = { (random) in
        //let a = Int.random(in: 1...100)
        print(random)
    }
    
    func todayNumber2(random: (Int) -> Void) { // Int -> Void
        random(8)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // dateFormat(date: Date())
        todayNumber2(random: { num in
            print(num * 100)
        })
        
        // ⬇️ 후행 클로저
        
        todayNumber2() { num in
            print(num * 100)
        }
    }
}

