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
    func backToQuizDetailsView(quiz_id: Int)
}

//@objc protocol backToQuizDetailsDelegate {
//    func goBackToQuizDetailsView(quiz_id: Int)
//}

class quizQuestionDetails: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet weak var backToQuizzesButton: UIButton!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var editQuestionButton: UIButton!
    
    var questionId: String?
    var quizId: Int?
    
    @IBOutlet var delegate: actionsFromQuizQuestionDetailsDelegate?
//    @IBOutlet var goBackToQuizDetailsDelegate: backToQuizDetailsDelegate?
    
    override class func awakeFromNib() {
        // la di da
    }
    
    func quizQuestionDetailsXibInit(quiz_id: Int, quiz_name: String, question_id: String, question_label: String, correct_answer_label: String) {
        quizNameLabel.text = "Quiz: \(quiz_name)"
        if correct_answer_label == "" {
            questionLabel.text = "\(question_label)"
            correctAnswerLabel.text = ""
            editQuestionButton.isHidden = true
        } else {
            questionLabel.text = "Question: \(question_label)"
            correctAnswerLabel.text = "Correct Answer: \(correct_answer_label)"
        }

        backToQuizzesButton.simpleButtonDesign(button: backToQuizzesButton, borderWidth: 0)
        editQuestionButton.simpleButtonDesign(button: editQuestionButton, borderWidth: 0)
        
        quizId = quiz_id
        questionId = question_id
        
    }
    
    @IBAction func backToQuizzesButtonPressed(_ sender: UIButton) {
        self.delegate?.backToQuizDetailsView(quiz_id: quizId!)
    }
    
    @IBAction func addQuestionButtonPressed(_ sender: UIButton) {
        self.delegate?.goToCreateEditQuestionScreen(quiz_id: quizId!, question_id: "0")
    }
    
    @IBAction func editQuestionButtonPressed(_ sender: UIButton) {
        self.delegate?.goToCreateEditQuestionScreen(quiz_id: quizId!, question_id: questionId!)
    }
    
}
