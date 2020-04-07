//
//  QuizQuestion.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/7/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

class QuizQuestion {
    
    let restAPIManager = RestAPIManager()
    
    func retrieveQuizQuestions(_ quiz_id: Int, _ user_id: Int) {
        let commandURL = "/quiz_questions"
        
        let jsonBody: [String: Int] = ["quiz_id": quiz_id, "user_id": user_id]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData, method: "GET")
    }
    
//    func injectQuizQuestions(_ questions: Data) {
//        let commandURL = "/quiz_questions"
//        
//        for i in range(0..questions) {
//            let json: [String: Any] = ["question_"+String(i): [""]]
//        }
//        
//    }
    
}
