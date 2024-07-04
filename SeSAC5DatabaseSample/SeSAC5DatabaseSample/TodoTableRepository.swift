//
//  RealmTableRepository.swift
//  SeSAC5DatabaseSample
//
//  Created by 황민채 on 7/4/24.
//

import Foundation

import RealmSwift

class TodoTableRepository {
    
    private let realm = try! Realm()
    
    // 레코드 생성
    func createItem(_ data: TodoTable) {
        
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
        
    }
    
    // 패치
    func fetchAll() -> [TodoTable] {
        let value = realm.objects(TodoTable.self).sorted(byKeyPath: "money", ascending: false)
        
        return Array(value)
    }
    
    func deleteItem(_ data: TodoTable) {
        try! realm.write {
            // list 를 제거하더라도 realm까지 변경 사항이 반영된다.
            realm.delete(data)
            
        }
    }
}
