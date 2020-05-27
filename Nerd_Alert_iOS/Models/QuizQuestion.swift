//
//  QuizQuestion.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct QuizQuestion: Decodable {
    var id: String
    var quizId: Int
    var question: String
    var choiceA: String?
    var choiceB: String?
    var choiceC: String?
    var choiceD: String?
    var correctAnswer: String
    var dateCreated: Date
    
    init(json: [String: Any]) {
        id = json["question_id"] as? String ?? "BLANK"
        quizId = json["quiz_id"] as? Int ?? 0
        question = json["question"] as? String ?? "BLANK"
        choiceA = json["choice_A"] as? String ?? "BLANK"
        choiceB = json["choice_B"] as? String ?? "BLANK"
        choiceC = json["choice_C"] as? String ?? "BLANK"
        choiceD = json["choice_D"] as? String ?? "BLANK"
        correctAnswer = json["correct_answer"] as? String ?? "BLANK"
        dateCreated = json["date_created"] as? Date ?? Date(timeIntervalSinceNow: 0)
    }
}
