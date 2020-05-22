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
    func goToCreateEditQuestionScreen(quiz_id: Int, question_id: String)
//    func goBackToQuizDetailsView(quiz_id: Int)
}

@objc protocol backToQuizDetailsDelegate {
    func goBackToQuizDetailsView(quiz_id: Int)
}

class quizQuestionDetails: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    var questionId: String?
    var quizId: Int?
    
    @IBOutlet var delegate: actionsFromQuizQuestionDetailsDelegate?
    @IBOutlet var goBackToQuizDetailsDelegate: backToQuizDetailsDelegate?
    
    override class func awakeFromNib() {
        // la di da
    }
    
    func quizQuestionDetailsXibInit(quiz_id: Int, quiz_name: String, question_id: String, question_label: String, correct_answer_label: String) {
        quizNameLabel.text = "Quiz: \(quiz_name)"
        questionLabel.text = "Question: \(question_label)"
        correctAnswerLabel.text = "Correct Answer: \(correct_answer_label)"
        
        quizId = quiz_id
        questionId = question_id
        
    }
    
    @IBAction func backToQuizzesButtonPressed(_ sender: UIButton) {
        self.goBackToQuizDetailsDelegate?.goBackToQuizDetailsView(quiz_id: quizId!)
    }
    
    @IBAction func addQuestionButtonPressed(_ sender: UIButton) {
        self.delegate?.goToCreateEditQuestionScreen(quiz_id: quizId!, question_id: "0")
    }
    
    @IBAction func editQuestionButtonPressed(_ sender: UIButton) {
        self.delegate?.goToCreateEditQuestionScreen(quiz_id: quizId!, question_id: questionId!)
    }
    
}
