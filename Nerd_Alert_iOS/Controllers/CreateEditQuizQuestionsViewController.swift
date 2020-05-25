//
//  EditQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/11/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateEditQuizQuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var choiceATextView: UITextView!
    @IBOutlet weak var choiceBTextView: UITextView!
    @IBOutlet weak var choiceCTextView: UITextView!
    @IBOutlet weak var choiceDTextView: UITextView!
    @IBOutlet weak var correctAnswerTextView: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    
    var quiz_id: Int?
    var question_id: String?
    var user_id: Int?
    
    var quizQuestionService = QuizQuestionSerivce()
    var quizQuestion: QuizQuestion?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        questionTextView.creatingPresentableTextFields(textView: questionTextView)
        choiceATextView.creatingPresentableTextFields(textView: choiceATextView)
        choiceBTextView.creatingPresentableTextFields(textView: choiceBTextView)
        choiceCTextView.creatingPresentableTextFields(textView: choiceCTextView)
        choiceDTextView.creatingPresentableTextFields(textView: choiceDTextView)
        correctAnswerTextView.creatingPresentableTextFields(textView: correctAnswerTextView)
        
        if question_id != "0" {
            actionButton.setTitle("Save Question", for: .normal)
            quizQuestionService.retrieveQuizQuestion(question_id: question_id!, onSuccess: { (response) in
                print("retrieveQuizQuestion API call successful")
                print(response)
                
                self.quizQuestion = QuizQuestion(json: response)
                
                DispatchQueue.main.async {
                    self.questionTextView.text = self.quizQuestion?.question
                    self.choiceATextView.text = self.quizQuestion?.choiceA
                    self.choiceBTextView.text = self.quizQuestion?.choiceC
                    self.choiceCTextView.text = self.quizQuestion?.choiceC
                    self.choiceDTextView.text = self.quizQuestion?.choiceD
                    self.correctAnswerTextView.text = self.quizQuestion?.correctAnswer
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
        if questionTextView.text != "" && choiceATextView.text != "" && choiceBTextView.text != "" && choiceCTextView.text != "" && choiceDTextView.text != "" && correctAnswerTextView.text != "" {
            
            if actionButton.titleLabel?.text == "Add Question" {
                quizQuestionService.injectQuizQuestion(quiz_id!, questionTextView.text!, choiceATextView.text!, choiceBTextView.text!, choiceCTextView.text!, choiceDTextView.text!, correctAnswerTextView.text!, onSuccess: { (response) in
                    print("generateQuizQuestion API call successful")
                    self.navigationController?.popViewController(animated: true)
                }, onFailure: { (error) in
                    print("ERROR generateQuizQuestion API call unsuccessful")
                    print(error)
                })
            } else if actionButton.titleLabel?.text == "Save Question" {
                quizQuestionService.reviseQuizQuestion(question_id!, questionTextView.text!, choiceATextView.text!, choiceBTextView.text!, choiceCTextView.text!, choiceDTextView.text!, correctAnswerTextView.text!, onSuccess: { (response) in
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
