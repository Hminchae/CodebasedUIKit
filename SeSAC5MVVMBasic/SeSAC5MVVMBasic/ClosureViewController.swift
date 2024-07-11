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
    
    let study: () -> Void = {
        print("으갸갸갸갸갸갹ㄱ")
    }
    
    let study2 = { () -> Void in
        print("주말에도 공부하기")
    }
    
    func getStudyWithMe(study: () -> ()) {
        print("주말에도 공부하기이이이")
        study()
    }
    
    func thanky(result: (Int) -> String) {
        result(Int.random(in: 1...1000))
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
        
        study()
        
        // 코드를 하나도 생략 안 하고 그대로 클로저 구문ㅇ르 사용한 상태
        // 함수 매개변수 내에 클로저가 그대로 들어간 형태
        // =>💡인라인(inline) 클로저
        getStudyWithMe(study: { () -> Void in
            print("주말에도 공부하기")
        })
        
        // =>💡함수 뒤에 클로저가 실행
        // 트레일링(후행)클로저
        getStudyWithMe() { () -> Void in
            print("주말에도 공부하기")
        }
        
        // (Int) -> String
        thanky(result: { (number: Int) -> String in
            return "행운의 숫자는 \(number)"
        })
        
        thanky { num in
            print(num)
            return "아아아ㅏ아아아아ㅏㅇ"
        }
        
        thanky() {
            "행운의 숫자는 \($0)"
        }
        
        thanky {
            "행운의 숫자는 \($0)"
        }
        
        // filter
        let student = [2.2, 4.23, 5.03, 245, 342, 31, 34134, 14, 1341]
        var newStudent: [Double] = []
        
        for i in student {
            if i >= 4.0 {
                newStudent.append(i)
            }
            print(newStudent)
            
            let filterStudent = student.filter { $0 >= 4.0 }
            
            print(filterStudent)
            
            let number = [Int](1...100)
            var newNumber: [Int] = []
            
            for i in number {
                newNumber.append(i*300)
            }
            print(number)
            
            let mapNumber = number.map { $0 * 3 }
            print(mapNumber)
            
            let stringNumber = number.map { $0 * 5 }
            print(stringNumber)
            
            let movieList = [
                "괴물": "봉준호",
                "기생충": "봉준호",
                "옥자": "봉준호",
                "인셉션": "놀란"
            ]
            
            let aa = movieList.filter { $0.value == "봉준호"}
            print(aa)
            
            let bb = movieList.filter { $0.value == "봉준호" }.map { $0.key }
        }
    }
}

