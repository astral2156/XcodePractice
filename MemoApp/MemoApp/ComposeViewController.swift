//
//  ComposeViewController.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/22.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        guard let memoTextView = memoTextView.text, memoTextView.count > 0 else{
            alert(message: "메모를 입력하세요")
            return
        }
        let newMemo = Memo(content: memoTextView)
        Memo.dummyList.append(newMemo)
        // notification to close save
        NotificationCenter.default.post(name: ComposeViewController.newMemoDidInserted, object: nil)
        dismiss(animated: true, completion: nil )
        
    }
    
    
    
}


extension ComposeViewController{
    static let newMemoDidInserted = Notification.Name(rawValue: "NewMemoDidInserted")
}
