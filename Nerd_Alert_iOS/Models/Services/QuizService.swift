//
//  QuizService.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/6/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

class QuizService {
    
    let restAPIManager = RestAPIManager()
    
    func retrieveQuizzes(_ user_id: Int, _ quiz_name: String?, _ createdBy: String?, _ source: String?, _ users_quizzes: Bool, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/retrieve_quiz"
        
        let jsonBody: [String: Any] = ["user_id": user_id,
                                       "quiz_name": quiz_name,
                                       "createdBy": createdBy,
                                       "source": source,
                                       "users_quizzes": users_quizzes]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: {responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func injectQuiz(quiz_name: String, quiz_description: String, source: String, title_of_source: String, createdBy: String, createdBy_user_id: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/generate_quiz"
        
        let jsonBody: [String: Any] = ["quiz_name": quiz_name,
                                       "quiz_description": quiz_description,
                                       "source": source,
                                       "title_of_source": title_of_source,
                                       "createdBy": createdBy,
                                       "createdBy_user_id": createdBy_user_id]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "POST",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })
    }
    
    func retreiveQuiz(_ quiz_id: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/find_quiz/\(quiz_id)"
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET",
                                   onSuccess: { responseJSON -> Void in
                                       onSuccess(responseJSON)
                                   },
                                   onFailure: { responseJSON -> Void in
                                       onFailure(responseJSON)
                                   })

    }
    
    func reviseQuiz(quiz_name: String, quiz_description: String, source: String, title_of_source: String, quiz_id: Int, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/update_quiz/\(quiz_id)"
        
        let jsonBody: [String: Any] = ["quiz_name": quiz_name,
                                       "quiz_description": quiz_description,
                                       "source": source,
                                       "title_of_source": title_of_source]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "PUT", onSuccess: { responseJSON -> Void in
            onSuccess(responseJSON)
        }, onFailure: { responseJSON -> Void in
            onFailure(responseJSON)
        })
    }
    
}
