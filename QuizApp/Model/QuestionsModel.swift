//
//  QuestionsModel.swift
//  QuizApp
//
//  Created by Shivakumar Harijan on 14/07/24.
//

import Foundation
struct QuestionStruct {
    let questionText: String
    let answer: Bool
    
    init(questionText: String, answer: Bool) {
        self.questionText = questionText
        self.answer = answer
    }
}

