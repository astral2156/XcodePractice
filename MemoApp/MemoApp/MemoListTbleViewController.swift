//
//  MemoListTbleViewController.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/22.
//

import UIKit

class MemoListTbleViewController: UITableViewController {

    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        // set language as Korean
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // true? animated
        // 뷰 컨트롤러가 화면에 표시되기 직전에 표시된다.
        // 페치 메모 메소드 호출을 해줘야함
        
        DataManager.shared.fetchMemo()
        // 메모 가져오고 배열이 채워짐
        tableView.reloadData()
        // 데이터 릴로드 해야함
        
        
//        tableView.reloadData()
//        print("is reloaded?")
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        // delete observer to prevent memory leak
        if let token = token {
            NotificationCenter.default.removeObserver(token)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // sender 의 위치를 계산해야함 셀을 테이블뷰로 전송해야함.
        if let cell = sender as?  UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            if let vc = segue.destination as? DetailViewController{
                vc.memo = DataManager.shared.memoList[indexPath.row]
                // 이렇게해서 메모 속성에 접근한다
                
            }
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInserted, object: nil, queue: OperationQueue.main){
            [weak self] (noti) in self?.tableView.reloadData()
            // should delete observer to block memory usage
        }
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.shared.memoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = DataManager.shared.memoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(for:target.insertDate)
        
//        cell.detailTextLabel?.text = .string(from:date)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 테이블 뷰의 편집기능 활성화됨
        return true
    }
    
    //편집 스타일 지정해야함
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let target = DataManager.shared.memoList[indexPath.row]
            DataManager.shared.deleteMemo(target)
            // DB 에서 지우고, 테이블의 갯수가 일치하지 않기에 테이블에서도 삭제해준다
            DataManager.shared.memoList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
            
        }
    }
    
    
//    func DateFormat(date: Date ) -> DateFormatter {
//        let f = DateFormatter()
//        f.dateStyle = .long
//        f.timeStyle = .short
//        print(f)
//
//        return f
//    }
    

}
