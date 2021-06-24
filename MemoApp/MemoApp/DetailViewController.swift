//
//  DetailViewController.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/24.
//

import UIKit

class DetailViewController: UIViewController {

    var memo: Memo? // 전송된 데이터가 여기에 저장됨
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        // set language as Korean
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // cell 이랑 연결
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            // cell 이랑 연결
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
        
        default:
            fatalError()
        }
        
    }
    
    
    
}
