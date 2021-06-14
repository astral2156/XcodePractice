//
//  ThirdViewController.swift
//  MultiVC
//
//  Created by Kim Duk Young on 2021/06/12.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet var field:UITextField!
    public var completionHandler : ((String?)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveCliced(){
        completionHandler?(field.text ?? "nothing")
        dismiss(animated: true, completion: nil)
        
    }
}
