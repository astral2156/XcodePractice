//
//  QuizStructure.swift
//  Quizzler-iOS13
//
//  Created by Kim, Dukyoung on 2021/01/01.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let question : String
    let answer : String
    
    
    init(q :String, a: String) {
        self.question = q
        self.answer = a
    }
}
