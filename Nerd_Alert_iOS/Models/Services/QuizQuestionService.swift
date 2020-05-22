//
//  QuizQuestion.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/7/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

class QuizQuestionSerivce {
    
    let restAPIManager = RestAPIManager()
    
    func injectQuizQuestion(_ quiz_id: Int, _ question: String, _ choice_A: String, _ choice_B: String, _ choice_C: String, _ choice_D: String, _ correct_answer: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/generate_quiz_questions"
        
        let jsonBody: [String: Any] = [
                                        "question": question,
                                        "choice_A": choice_A,
                                        "choice_B": choice_B,
                                        "choice_C": choice_C,
                                        "choice_D": choice_D,
                                        "correct_answer": correct_answer
                                      ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    
    func retrieveQuizQuestions(_ quiz_id: Int, _ user_id: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_quiz_questions"
        
        let jsonBody: [String: Int] = ["quiz_id": quiz_id, "user_id": user_id]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func retrieveQuizQuestion(question_id: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_quiz_question/questionId/\(question_id)"
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET",
                           onSuccess: { responseJSON -> Void in
                               onSuccess(responseJSON)
                           },
                           onFailure: { responseJSON -> Void in
                               onFailure(responseJSON)
                           })
    }
    
    func reviseQuizQuestion(_ question_id: String, _ question: String, _ choice_A: String, _ choice_B: String, _ choice_C: String, _ choice_D: String, _ correct_answer: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/update_quiz_question/questionId/\(question_id)"
        
        let jsonBody: [String: Any] = [
                                        "question": question,
                                        "choice_A": choice_A,
                                        "choice_B": choice_B,
                                        "choice_C": choice_C,
                                        "choice_D": choice_D,
                                        "correct_answer": correct_answer
                                      ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "PUT",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func retrieveNumberOfQuizQuestions(_ quiz_id: Int, _ user_id: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_number_of_quiz_questions/quizId/\(quiz_id)"
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET", onSuccess: { responseJSON -> Void in
            onSuccess(responseJSON)
        }, onFailure: { responseJSON -> Void in
            onFailure(responseJSON)
        })
    }
    
    func retrieveQuizQuestionsBasedOnIds(question_ids: [String], onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_quiz_questions_by_ids"
        
        let jsonBody: [String: [String]] = ["question_ids": question_ids]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST", onSuccess: { responseJSON -> Void in
            onSuccess(responseJSON)
        }, onFailure: { responseJSON -> Void in
            onFailure(responseJSON)
        })
    }
    
//    func injectQuizQuestions(_ questions: Data) {
//        let commandURL = "/quiz_questions"
//        
//        for i in 0..questions.count {
//            let json: [String: Any] = ["question_"+String(i): [""]]
//        }
//        
//    }
    
}
