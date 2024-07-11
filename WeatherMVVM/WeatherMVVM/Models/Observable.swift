//
//  Observable.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/11/24.
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
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
