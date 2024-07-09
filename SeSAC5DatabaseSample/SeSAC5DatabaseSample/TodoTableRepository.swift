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
    func createItem(_ data: TodoTable, folder: Folder) {
        
        do {
            try realm.write {
                
                folder.detail.append(data)
                
                //realm.add(data)
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
    
    func detectRealmTable() {
        print(realm.configuration.fileURL ?? "")
    }
    
    // --
    
    func fetchFolder() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func removeFolder(_ folder: Folder) {
        do {
            try realm.write {
                realm.delete(folder.detail) // 필요한 프로퍼티들을 먼저 제거를 해주어야 함
                realm.delete(folder)
                print("Folder Remove Succeed")
            }
            print("Folder Remove Succeed")
        } catch {
            print("Folder Remove Succeed")
        }
    }
    
    func addMemoInFolder(_ folder: Folder) {
        
        let memo = Memo()
        memo.content = "이렇게 메모를 추가할까요?"
        memo.regDate = Date()
        memo.editDate = Date()
        
        do {
            try realm.write {
                folder.memo.append(memo)
            }
        } catch {
            print("Folder Memo Failed")
        }
    }
}
