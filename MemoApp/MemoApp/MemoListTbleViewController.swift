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
                vc.memo = Memo.dummyList[indexPath.row] //이렇게해서 메모 속성에 접근한다
                
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInserted, object: nil, queue: OperationQueue.main){
            [weak self] (noti) in self?.tableView.reloadData()
            // should delete observer to block memory usage
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Memo.dummyList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = Memo.dummyList[indexPath.row]
        cell.textLabel?.text = target.content
//        let date = DateFormat(date: target.insertDate)
        
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)
        
//        cell.detailTextLabel?.text = .string(from:date)
        // Configure the cell...

        return cell
    }
//    func DateFormat(date: Date ) -> DateFormatter {
//        let f = DateFormatter()
//        f.dateStyle = .long
//        f.timeStyle = .short
//        print(f)
//
//        return f
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
