//
//  quizResults.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/29/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

@objc protocol actionsFromQuizResultsDelegate {
    func viewQuizQuestionResults()
    func goBackToQuizDetails(quiz_id: Int)
}

class quizResults: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var quizIterationScore: UILabel!
    
    @IBOutlet var delegate: actionsFromQuizResultsDelegate?
    
    var quizId : Int?
    var quizResult: QuizResults?
    
    func quizResultsXibInit(quiz_name: String, quiz_result: QuizResults) {
        quizNameLabel.text = "Quiz: \(quiz_name)"
        
        quizId = quiz_result.quizId
        quizResult = quiz_result
        
    }
    
    @IBAction func returnToQuizDetailsButtonPressed(_ sender: UIButton) {
        print("quiz id returning to: \(quizId!)")
        self.delegate?.goBackToQuizDetails(quiz_id: quizId!)
    }
    
    @IBAction func viewQuestionResultsButtonPressed(_ sender: UIButton) {
        if let quiz_result = quizResult {
            print("viewing quiz '\(quizNameLabel.text)' iteration \(quiz_result.quizIteration)")
        }
    }
}
