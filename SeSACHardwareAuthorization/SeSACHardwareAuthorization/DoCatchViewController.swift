//
//  DoCatchViewControlleer.swift
//  SeSACHardwareAuthorization
//
//  Created by 황민채 on 6/18/24.
//

import UIKit

import SnapKit

/*
 💡 오류처리 패턴
 >> 컴파일러가 오류의 타입을 인정하게 된다.
 
 */

@frozen enum ValidationError: Error {
    case emptyString
    case isNotInt // ❌ intError -> 식으로 사용 지양
    case isNotDate
}

class DoCatchViewController: UIViewController {
    
    let userTextField = UITextField()
    let checkButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(userTextField)
        view.addSubview(checkButton)
        
        userTextField.backgroundColor = .systemGray
        checkButton.backgroundColor = .systemBlue
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        configureLayout()
    }
    
    func configureLayout() {
        userTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        
    }
    
    //✅ 유효성 검사
    
    
    @objc func checkButtonClicked() {
        guard let text = userTextField.text else { return }
        
        // do try catch
        // try? try!
        
        // 👎
        /*
        let result = try? validateUserInput(text: text)
        print(result)
        */
        
        // 👍
        do {               //⬇️ throwing function
            let result = try validateUserInput(text: text)
            print(result)
        } catch ValidationError.emptyString {
            print("빈값이에요")
        } catch ValidationError.isNotInt {
            print("숫자가 아니에요")
        } catch ValidationError.isNotDate {
            print("날짜가 아니에요")
        } catch {
            print("이건머지")
        }
        
    }
    
    
    // 1️⃣ 빈값 여부
    // 2️⃣ 숫자 여부
    // 3️⃣ 날짜 형식
    // throwing function
    // 에러를 발생시킬 수 있다는 것을 알리기 위해 throw 키워드를 함수 선언부의 파라미터 뒤에다가 붙임
    /*
    func validateUserInput(text: String) -> Bool {
        guard !text.isEmpty else {
            print("빈값")
            
            return false
        }
        guard Int(text) != nil else {
            print("숫자가 아닙니다...")
            return false
        }
        
        guard checkDateFormat(text: text) else {
            print("날짜 형태가 잘못되었음")
            return false
        }
        return true
    }
    */
    
    //⬇️ throwing function
    @discardableResult
    func validateUserInput(text: String) throws -> Bool {
        guard !text.isEmpty else {
            
            print("빈값")
            
            throw ValidationError.emptyString
            
        }
        guard Int(text) != nil else {
            
            print("숫자가 아닙니다...")
            
            throw ValidationError.isNotInt
            
        }
        
        guard checkDateFormat(text: text) else {
            
            print("날짜 형태가 잘못되었음")
            
            throw ValidationError.isNotDate
        }
        
        return true
    }
    
    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        return format.date(from: text) == nil ? false : true
    }
}
