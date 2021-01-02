//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var mainBoard: UILabel!
    @IBOutlet weak var trueBtn: UIButton!
    @IBOutlet weak var falseBtn: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    var questionNum = 0

    let quiz = [
        Question(q: "김덕영", a: "True"),
        Question(q: "남도산", a: "True"),
        Question(q: "아에", a: "True"),
        Question(q: "이오우", a: "True"),
        
    ]
    
    override func viewDidLoad() {
        mainBoard.text = quiz[questionNum].question
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle
        let actualAnswer = quiz[questionNum].answer
        
        if userAnswer == actualAnswer{
            print("correct!")
            sender.backgroundColor = UIColor.green
        } else {
            print("wrong!")
            sender.backgroundColor = UIColor.red
            
        }

        if questionNum + 1 < quiz.count{
            print("question num \(questionNum) ")
            questionNum += 1

        } else {
            // 큐 전부 다 돌은 후 0으로 리셋
            questionNum = 0
        }
        
        // 시간 기다렸다 실행
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUi), userInfo: nil, repeats: false)

    }
    
    @objc func updateUi() {
        mainBoard.text = quiz[questionNum].question
        trueBtn.backgroundColor = UIColor.clear
        falseBtn.backgroundColor = UIColor.clear
        progressBar.progress = Float(questionNum) / Float(quiz.count)
    }
    
}
