//
//  QuizResultsService.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/25/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

class QuizResultsService {
    
    let restAPIManager = RestAPIManager()
    
    func injectQuizResult(_ userId: Int, _ quizId: Int, _ quizIteration: Int, _ score: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/enter_user_quiz_results"
        
        let jsonBody: [String: Any] = ["user_id": userId,
                                       "quiz_id": quizId,
                                       "quiz_iteration": quizIteration,
                                       "score": score]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func retrieveQuizResults(_ userId: Int, _ quizId: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_user_quiz_results"
        
        let jsonBody: [String: Int] = ["user_id": userId,
                                       "quiz_id": quizId]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
        
    }
    
    func retrieveQuizResult(userId: Int, quizId: Int, quizIteration: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_user_quiz_result/user_id/\(userId)/quiz_id/\(quizId)/quiz_iteration/\(quizIteration)"
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func retrieveQuizIteration(_ userId: Int, _ quizId: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_quiz_iteration"
        
        let jsonBody: [String: Int] = ["user_id": userId,
                                       "quiz_id": quizId]
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
