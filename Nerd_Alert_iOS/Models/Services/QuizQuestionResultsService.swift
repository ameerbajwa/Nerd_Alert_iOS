//
//  QuizQuestionResultsService.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/25/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

class QuizQuestionsResultsService {
    
    let restAPIManager = RestAPIManager()
    
    func injectQuizQuestionsResults(_ quizQuestionResults: [QuizQuestionsResults], onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/enter_user_question_results"
        
        var jsonBody: [String: [String: Any]] = [:]
        var questionResult: [String: Any] = [:]
        for i in 0...9 {
            questionResult["user_id"] = quizQuestionResults[i].userId
            questionResult["quiz_id"] = quizQuestionResults[i].quizId
            questionResult["question_id"] = quizQuestionResults[i].questionId
            questionResult["quiz_iteration"] = quizQuestionResults[i].quizIteration
            questionResult["user_answer"] = quizQuestionResults[i].userAnswer
            questionResult["correct_answer"] = quizQuestionResults[i].correctAnswer
            jsonBody["question_\(i)"] = questionResult
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func retrieveQuizQuestionsResults(_ userId: Int, _ quizId: Int, _ quizIteration: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "retrieve_user_question_results"
        
        let jsonBody: [String: Int] = ["user_id": userId,
                                       "quiz_id": quizId,
                                       "quiz_iteration": quizIteration]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
        
    }
    
}
