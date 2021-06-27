//
//  DataManger.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/26.
//

import Foundation
import CoreData

class DataManager {
    
    // 공유 인스턴스 저장용
    // 이걸로 앱 전체에서 자료 공유
    // 싱글톤 패턴
    
    static let shared = DataManager()
    private init(){
        
    }
    
    var mainContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()

    
    // 데이터 읽어오는 부분
    func fetchMemo() {
        // data fetching
        let request : NSFetchRequest<Memo> = Memo.fetchRequest()
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        // DB 에서 날짜 반대 기준으로 정렬된 데이터가
        // 밑에 부분에서 memoList에 추가되어 들어온다
        
        // catch exception in swift grammar
        do {
            memoList = try mainContext.fetch(request)
        } catch{
            print(error)
        }
    }
    
    func addNewMemo(_ memo: String?){
        print("addNewMemo")
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.insertDate = Date()
        // 여기서 바로 insert 로 삽입시 메모가 맨 처음에 온다
        // append 해줄 경우 맨 뒤에 온다
        memoList.insert(newMemo, at: 0)
//        memoList.append(newMemo)
        
        saveContext()
    }
    
    // 삭제 메모 구현
    func deleteMemo(_ memo: Memo?){
        if let memo = memo{
            mainContext.delete(memo)
            saveContext()
        }
        
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MemoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        print("saveContext func start")
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

