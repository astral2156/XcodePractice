//
//  model.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/20.
//

import Foundation


class Memo{
    var content : String
    var insertDate : Date
    
    init(content: String) {
        self.content = content
        insertDate = Date()
    }
    
    static var dummyList = [
        Memo(content: "ABC"),
        Memo(content: "DEF"),
        Memo(content: "EEE"),
    ]
}
