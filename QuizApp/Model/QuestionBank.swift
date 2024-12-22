//
//  QuestionBank.swift
//  QuizApp
//
//  Created by Shivakumar Harijan on 14/07/24.
//

import Foundation

class QuestionBank {
    var qList = [QuestionStruct]()
    init(){
        let item = QuestionStruct(questionText: "Valentine's day is banned in Saudi Arabial", answer: true)
        qList.append(item)
        
        qList.append(QuestionStruct(questionText: "Delhi is the Capital City of Pakistan", answer: false))
        qList.append(QuestionStruct(questionText: "Raja Babu is from London", answer: false))
        qList.append(QuestionStruct(questionText: "Hydrabd is Capital of Telngana", answer: true))
    }
}
