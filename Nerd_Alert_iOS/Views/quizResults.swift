//
//  quizResults.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/29/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

@objc protocol actionsFromQuizResultsDelegate {
    func viewQuizQuestionResults(quiz_id: Int, quiz_iteration: Int)
    func goBackToQuizDetailsView(quiz_id: Int)
}
//
//@objc protocol backToQuizDetailsDelegate {
//    func goBackToQuizDetailsView(quiz_id: Int)
//}

class quizResults: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var quizIterationScore: UILabel!
    @IBOutlet weak var numberOfQuestionsLabel: UILabel!
    @IBOutlet weak var goBackToQuizDetailsButton: UIButton!
    @IBOutlet weak var viewQuestionResultsButton: UIButton!
    
    @IBOutlet var delegate: actionsFromQuizResultsDelegate?
//    @IBOutlet var quizDetailsDelegate: backToQuizDetailsDelegate?
    
    var quizResult: QuizResults?
    var overallscore: Int = 0
    
    func quizResultsXibInit(quiz_name: String, quiz_result: QuizResults, quiz_results: [QuizResults], number_of_questions: Int) {
        quizResult = quiz_result
        
        for result in quiz_results {
            overallscore += result.score
        }
        
        quizNameLabel.text = "Quiz: \(quiz_name)"
        overallScoreLabel.text = "User's overall score for this quiz: \(overallscore)/\(quiz_results.count*10)"
        quizIterationScore.text = "Score: \(quizResult!.score)/10"
        numberOfQuestionsLabel.text = "Questions answered over total questions: \(quiz_results.count*10)/\(number_of_questions)"
        
        goBackToQuizDetailsButton.simpleButtonDesign(button: goBackToQuizDetailsButton, borderWidth: 0)
        goBackToQuizDetailsButton.setTitle("Back To Quiz Details", for: .normal)
        viewQuestionResultsButton.simpleButtonDesign(button: viewQuestionResultsButton, borderWidth: 0)
        viewQuestionResultsButton.setTitle("View Quiz Question Results", for: .normal)
        
    }
    
    @IBAction func returnToQuizDetailsButtonPressed(_ sender: UIButton) {
        print("quiz returning to id: \(quizResult!.quizId)")
//        self.delegate?.goBackToQuizDetails(quiz_id: quizResult!.quizId)
        self.delegate?.goBackToQuizDetailsView(quiz_id: quizResult!.quizId)
    }
    
    @IBAction func viewQuestionResultsButtonPressed(_ sender: UIButton) {
        if let quiz_result = quizResult {
            print("viewing quiz '\(quizNameLabel.text)' iteration \(quizResult?.quizIteration)")
            self.delegate?.viewQuizQuestionResults(quiz_id: quizResult!.quizId, quiz_iteration: quizResult!.quizIteration)
        }
    }
}
