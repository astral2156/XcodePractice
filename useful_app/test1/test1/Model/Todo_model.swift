//
//  Todo_model.swift
//  test1
//
//  Created by Kim Duk Young on 2021/02/22.
//

import Foundation

class Todo_List{
    var content: String
    var date : Date
    
    init(content: String) {
        self.content = content
        date = Date()
    }
    
    static var dummyMemo = [
        Todo_List(content: "abc"),
        Todo_List(content: "def")
    ]
    
}
