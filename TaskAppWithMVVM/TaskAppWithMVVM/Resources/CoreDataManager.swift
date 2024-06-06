//
//  CoreDataManager.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/6/24.
//

import CoreData
import Foundation

/*
 ✏️ 싱글턴 패턴 : 클래스의 인스턴스가 오직 하나만 생성되어야할 때 사용하는 디자인 패턴.
    싱글턴 패턴의 사용 이유 :
    1. 자원 공유 및 접근 제어 : 앱내에서 데이터베이스 연결, 네트워크 세션, 사용자 설정 등 공유되어야 하는 자원을 효과적으로 관리할 수 있음
    2. 데이터 일관성 : 단일 인스턴스를 통해 모든 데이터 접근이 이루어지므로, 데이터 일관성을 유지하기 쉽다.
 
    싱글턴 패턴의 단점 :
    1. 전역 인스턴스 : 전역적으로 접근 가능하기 때문에, 코드 어디에서든 수정할 수 있어 예기치 못한 사이트 이펙트가 발생할 수 있음
    2. 스레드 안전성 : 여러 스레드에서 동시에 접근할 경우 스레드 안전성을 보장하여야 하며, 이를 위한 추가적인 처리가 필요함
 */

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    // Task를 담을 컨테이너 생성
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // NSManagedObjectContext에 접근할 때 사용할 변수
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // context에 변경사항이 있을 때 사용할 메서드
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error saving the staged changes \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // CoreData에서 모든 Task 객체를 가져오는 메서드
    func getAll() -> [Task] {
        var tasks = [Task]()
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return tasks
    }
}
