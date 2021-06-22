//
//  UIViewController+Allert.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/22.
//

import UIKit

extension UIViewController{
    func alert(title: String = "알람", message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)

    }
    
}
