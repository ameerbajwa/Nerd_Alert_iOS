//
//  quizQuestionDetails.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/20/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

@objc protocol actionsFromQuizQuestionDetailsDelegate {
    func goToCreateEditQuestionScreen()
    func goBackToQuizDetailsView()
}

class quizQuestionDetails: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet var delegate: actionsFromQuizQuestionDetailsDelegate?
    
    override class func awakeFromNib() {
        // la di da
    }
    
    func quizQuestionDetailsXibInit(quiz_name: String, question_label: String, correct_answer_label: String) {
        quizNameLabel.text = "Quiz: \(quiz_name)"
        questionLabel.text = "Question: \(question_label)"
        correctAnswerLabel.text = "Correct Answer: \(correct_answer_label)"
        
    }
    
    @IBAction func backToQuizzesButtonPressed(_ sender: UIButton) {
        self.delegate?.goBackToQuizDetailsView()
    }
    
    @IBAction func addQuestionButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func editQuestionButtonPressed(_ sender: UIButton) {
    }
    
}
