//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let egg_time = ["Soft": 5, "Medium":7, "Hard":9]
    var timer = Timer()
    var seconds_remaining = 10

    @IBOutlet weak var title_label: UILabel!
    
    @IBOutlet weak var progBar: UIProgressView!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        progBar.progress = 0.0
        
        timer.invalidate()
        
        seconds_remaining = egg_time[sender.currentTitle!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        

        
    }
    @objc func updateTimer(){
        if seconds_remaining == 0{
            timer.invalidate()
        }
        
        title_label.text = "time left \(seconds_remaining)"
        
        print("time left \(seconds_remaining)")
        seconds_remaining -= 1
        updateProgBar()
        
    }
    
    func updateProgBar(){
        progBar.setProgress(Float(seconds_remaining), animated: true)
    }
    
}
