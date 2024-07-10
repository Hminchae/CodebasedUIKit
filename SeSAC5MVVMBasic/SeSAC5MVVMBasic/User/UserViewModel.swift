//
//  UserViewModel.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

class UserViewModel {
    
    // 1. observable로 표현할래
    // 2. viewModel에 상수로
    // 3. 열거형에서 뷰컨에서 바로 갖고 올래
    
    // 처음에 로드
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    // UserList
    var outputList = Observable([User(name: "thanky", age: 28)])
    // +
    var inputAddButtonTapped: Observable<Void?> = Observable(nil)
    // 전체 삭제
    var inputRemoveButtonTapped: Observable<Void?> = Observable(nil)
    
    // 검색
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            let user = [
                User(name: generateRandomName(),
                     age: .random(in: 1...100)),
                User(name: generateRandomName(),
                     age: .random(in: 1...100)),
                User(name: generateRandomName(),
                     age: .random(in: 1...100)),
                User(name: generateRandomName(),
                     age: .random(in: 1...100)),
                User(name: generateRandomName(),
                     age: .random(in: 1...100)),
            ]
            self.outputList.value = user
        }
        func generateRandomName() -> String {
            let firstNames = ["John", "Jane", "Mike", "Emily", "David", "Sarah", "Chris", "Anna"]
            let lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Wilson"]
            
            let randomFirstName = firstNames.randomElement() ?? ""
            let randomLastName = lastNames.randomElement() ?? ""
            
            return "\(randomFirstName) \(randomLastName)"
        }
        inputRemoveButtonTapped.bind { _ in
            self.outputList.value.removeAll()
        }
        inputAddButtonTapped.bind { _ in
            print("====================")
            let user = User(name: "dfad", age: .random(in: 1...100))
            self.outputList.value.append(user)
        }
        
    }
    
    
    
    
}
