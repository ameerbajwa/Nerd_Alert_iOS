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
    @IBOutlet weak var quizResultScrollView: UIScrollView!
    
    @IBOutlet var delegate: actionsFromQuizResultsDelegate?
    
    var quizId : Int?
    
    func quizResultsXibInit(quiz_name: String, quiz_results: [QuizResults]) {
        quizNameLabel.text = "Quiz: \(quiz_name)"
        
        let qrView = quizResultView()
        quizId = quiz_results[0].quizId
                
        for i in 0..<quiz_results.count {
            print(quiz_results[i])
            print(quiz_results[i].quizIteration)
            print(type(of: quiz_results[i].quizIteration))
        
//            qrView.quizNumberButton.setTitle("Quiz #\(quiz_results[i].quizIteration)", for: .normal)
//            qrView.quizScoreLabel.text = "Score: \(quiz_results[i].score)/10"
//
//            quizResultScrollView.addSubview(qrView)
        }
        
    }
    
    @IBAction func returnToQuizDetailsButtonPressed(_ sender: UIButton) {
        self.delegate?.goBackToQuizDetails(quiz_id: quizId!)
    }
    
}
