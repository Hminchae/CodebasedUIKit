//
//  Observable.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/9/24.
//

import Foundation

class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet")
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) { //매개변수에 반가워가 들어갔음
        // closure(value) // <- 인스턴스 첫 생성 시 안녕방가워를 호출하기 위함
        self.closure = closure
    }
}
