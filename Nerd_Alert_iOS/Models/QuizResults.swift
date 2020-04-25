//
//  QuizResults.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/25/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct QuizResults: Decodable {
    var userId: Int
    var quizId: Int
    var quizIteration: Int
    var score: Int
    var dateCreated: String
    
    init(json: [String: Any]) {
        userId = json["user_id"] as? Int ?? 0
        quizId = json["quiz_id"] as? Int ?? 0
        quizIteration = json["iteration"] as? Int ?? 0
        score = json["score"] as? Int ?? 0
        dateCreated = json["date_created"] as? String ?? "BLANK"
    }
}
