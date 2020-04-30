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
    func goBackToQuizDetails()
}

class quizResults: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var quizNumberButton: UIButton!
    @IBOutlet weak var quizNumberScoreLabel: UILabel!
    
    @IBOutlet var delegate: actionsFromQuizResultsDelegate?
    
    func quizResultsXibInit(quiz_name: String, quiz_results: [QuizResults]) {
        quizNameLabel.text = "Quiz: \(quiz_name)"
    }
    
    @IBAction func quizNumberButtonPressed(_ sender: UIButton) {
    }
}
