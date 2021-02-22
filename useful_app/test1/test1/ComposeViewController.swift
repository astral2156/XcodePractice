//
//  ComposeViewController.swift
//  test1
//
//  Created by Kim Duk Young on 2021/02/22.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var todoTextView: UITextView!
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        let todo = todoTextView.text
        
        let new_todo = Todo_List(content: todo ?? " ")
        Todo_List.dummyMemo.append(new_todo)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
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
