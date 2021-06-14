//
//  ViewController.swift
//  MultiVC
//
//  Created by Kim Duk Young on 2021/06/12.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet var label : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    @IBAction func didTabBtn(){
        present(SecondViewController(), animated: true)
    }
    
    
    @IBAction func didAppleTabBtn(){
        let vc = SFSafariViewController(url: URL(string: "www.apple.com")!)
        present(vc, animated: true)
        
    }

}

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    

}
