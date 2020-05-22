//
//  EditQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/11/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateEditQuizQuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var choiceATextField: UITextField!
    @IBOutlet weak var choiceBTextField: UITextField!
    @IBOutlet weak var choiceCTextField: UITextField!
    @IBOutlet weak var choiceDTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var quiz_id: Int?
    var question_id: String?
    var user_id: Int?
    
    var quizQuestionService = QuizQuestionSerivce()
    var quizQuestion: QuizQuestion?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let questionId = question_id {
            actionButton.setTitle("Save Question", for: .normal)
            quizQuestionService.retrieveQuizQuestion(question_id: questionId, onSuccess: { (response) in
                print("retrieveQuizQuestion API call successful")
                print(response)
                
                self.quizQuestion = QuizQuestion(json: response)
                
                DispatchQueue.main.async {
                    self.questionTextField.text = self.quizQuestion?.question
                    self.choiceATextField.text = self.quizQuestion?.choiceA
                    self.choiceBTextField.text = self.quizQuestion?.choiceC
                    self.choiceCTextField.text = self.quizQuestion?.choiceC
                    self.choiceDTextField.text = self.quizQuestion?.choiceD
                    self.correctAnswerTextField.text = self.quizQuestion?.correctAnswer
                }
                
            }, onFailure: {(error) in
                print("ERROR retrieveQuizQuestion API call unsucessful")
                print(error)
            })
        } else {
            actionButton.setTitle("Add Question", for: .normal)
        }

    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        if questionTextField.text != "" && choiceATextField.text != "" && choiceBTextField.text != "" && choiceCTextField.text != "" && choiceDTextField.text != "" && correctAnswerTextField.text != "" {
            
            if actionButton.titleLabel?.text == "Add Question" {
                quizQuestionService.injectQuizQuestion(quiz_id!, questionTextField.text!, choiceATextField.text!, choiceBTextField.text!, choiceCTextField.text!, choiceDTextField.text!, correctAnswerTextField.text!, onSuccess: { (response) in
                    print("generateQuizQuestion API call successful")
                    self.navigationController?.popViewController(animated: true)
                }, onFailure: { (error) in
                    print("ERROR generateQuizQuestion API call unsuccessful")
                    print(error)
                })
            } else if actionButton.titleLabel?.text == "Save Question" {
                quizQuestionService.reviseQuizQuestion(question_id!, questionTextField.text!, choiceATextField.text!, choiceBTextField.text!, choiceCTextField.text!, choiceDTextField.text!, correctAnswerTextField.text!, onSuccess: { (response) in
                    print("reviseQuizQuestion API call successful")
                    self.navigationController?.popViewController(animated: true)
                }, onFailure: { (error) in
                    print("ERROR reviseQuizQuestion API call unsuccessful")
                    print(error)
                })
            }
            
        }
    }
}
