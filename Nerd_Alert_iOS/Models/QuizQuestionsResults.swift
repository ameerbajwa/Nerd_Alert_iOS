//
//  QuizQuestionsResults.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/25/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct QuizQuestionsResults: Decodable {
    var userId: Int
    var quizId: Int
    var questionId: String
    var quizIteration: Int
    var userAnswer: String
    var correctAnswer: String
    
    init(json: [String: Any]) {
        userId = json["user_id"] as? Int ?? 0
        quizId = json["quiz_id"] as? Int ?? 0
        questionId = json["question_id"] as? String ?? "BLANK"
        quizIteration = json["quiz_iteration"] as? Int ?? 0
        userAnswer = json["user_answer"] as? String ?? "BLANK"
        correctAnswer = json["correct_answer"] as? String ?? "BLANK"
    }
}
