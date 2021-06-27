//
//  DetailViewController.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/24.
//

import UIKit

class DetailViewController: UIViewController {

    var memo: Memo? // 전송된 데이터가 여기에 저장됨
    
    @IBOutlet weak var memoTableView: UITableView!
    // 업데이트시 re load 하기 위함
    
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        // set language as Korean
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()
    
    
    // memo 공유 버튼
    @IBAction func share(_ sender: UIBarButtonItem) {
        
        guard let memo = memo?.content else {return}
        
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        if let pc = vc.popoverPresentationController{
            pc.barButtonItem = sender
        }
        
        present(vc, animated: true, completion: nil)
            
    }
    
    
    // 메모를 삭제하는 버튼. Trash btn
    @IBAction func deleteMemo(_ sender: Any) {
        let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제 할가요?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .destructive) {
            [weak self] (action) in
            // DataManager 의 deleteMemo func 호출
            DataManager.shared.deleteMemo(self?.memo)
            // 닫은 후 화면을 전환시켜줘야함 화면 팝,
            // 네비게이션 컨트롤러가 화면 전환 담당
            // 밑에 코드로 네컨 접근 후 화면 팝 
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okButton)
        let cancelButton = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            
            vc.editTarget = memo
        }// 네비게이션 뷰 컨트롤러로 데이터 전송
        
    }
    
    var token: NSObjectProtocol?
    // 옵저버 해제
    deinit {
        if let token = token{
            NotificationCenter.default.removeObserver(token)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 옵저버 추가
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.memoTableView.reloadData()})
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
    // 테이블 뷰에 데이터 업데이트 중
    
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
