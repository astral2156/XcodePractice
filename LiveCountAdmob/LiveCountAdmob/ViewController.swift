//
//  ViewController.swift
//  LiveCountAdmob
//
//  Created by Kim Duk Young on 2021/06/28.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var bigTextView: UITextView!
    @IBOutlet weak var smallTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bigTextView.delegate = self
    }

}

// spread sheet ID : 14a2QXym90tzfQH8e3loCRrxSgIE4RS4fCTOEMndjW3g

