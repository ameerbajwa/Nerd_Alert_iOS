//
//  QuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/23/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var quizIterationLabel: UILabel!
    @IBOutlet weak var quizQuestionNumberLabel: UILabel!
    @IBOutlet weak var quizQuestion: UILabel!
    
    @IBOutlet weak var userAnswerTextField: UITextField!
    @IBOutlet weak var choiceAButton: UIButton!
    @IBOutlet weak var choiceBButton: UIButton!
    @IBOutlet weak var choiceCButton: UIButton!
    @IBOutlet weak var choiceDButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var quiz_id: Int?
    var quiz_name: String?
    var question_number: Int = 0
    var users_answers: [Int: String?] = [:]
    var quiz_iteration: Int = 0
    
    var quizQuestionService = QuizQuestionSerivce()
    var quizService = QuizService()
    var quizResultsService = QuizResultsService()
    
    var quizQuestions: [QuizQuestion] = []
    var question: QuizQuestion?
    var quiz: Quiz?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("retreiving quiz name")
//        quizService.retreiveQuiz(quiz_id!, onSuccess: { (response) in
//            print("From Swift Application: retrieveQuiz function called")
//            print(response)
//            self.quiz = Quiz(json: response)
//            self.quizNameLabel.text = self.quiz?.name
//
//        }, onFailure: { (error) in
//            print("From Swift Application: retrieveQuiz function called and an error occured")
//            print(error)
//        })
        self.quizNameLabel.text = "Quiz: \(self.quiz_name!)"
        
        print("retrieving the quiz iteration number the user will be taking")
        quizResultsService.retrieveQuizIteration(user!.id, quiz_id!, onSuccess: { (response) in
            print("From Swift Application: retrieveQuizIteration function called")
            print(response)
            self.quiz_iteration = response["quiz_iteration"] as! Int
            self.quizIterationLabel.text = "Quiz #\(self.quiz_iteration)"
            
            DispatchQueue.main.async {
                print("retreiving questions from quiz")
                self.quizQuestionService.retrieveQuizQuestions(self.quiz_id!, self.user!.id, onSuccess: { (response) in
                    print("From Swift Application: retrieveQuizQuestions function called")
                    print(response.count)
                    
                    for i in response.keys {
                        self.question = QuizQuestion(json: response[i] as! [String : Any])
                        self.quizQuestions.append(self.question!)
                    }
                    
                    DispatchQueue.main.async {
                        self.changingQuestions()
                    }
                    
                }, onFailure: { (error) in
                    print("From Swift Application: retrieveQuizzes function called and an error occured")
                    print(error)
                })
            }
            
        }, onFailure: { (error) in
            print("From Swift Application: retrieveQuizIteration function called and an error occured")
            print(error)
        })


        
    }
    
    func changingQuestions() {
        
        if question_number == 0 {
            backButton.isHidden = true
        } else if question_number == 9 {
            nextButton.setTitle("Submit Quiz", for: .normal)
        }
        
        quizQuestionNumberLabel.text = "Question #\(question_number+1)"
        quizQuestion.text = quizQuestions[question_number].question
        
        if quizQuestions[question_number].choiceA == nil && quizQuestions[question_number].choiceB == nil && quizQuestions[question_number].choiceC == nil && quizQuestions[question_number].choiceD == nil {
            choiceAButton.isHidden = true
            choiceBButton.isHidden = true
            choiceCButton.isHidden = true
            choiceDButton.isHidden = true
            
        } else if quizQuestions[question_number].choiceC == nil && quizQuestions[question_number].choiceD == nil {
            choiceCButton.isHidden = true
            choiceDButton.isHidden = true
            userAnswerTextField.isHidden = true
            
            choiceAButton.setTitle(quizQuestions[question_number].choiceA, for: .normal)
            choiceBButton.setTitle(quizQuestions[question_number].choiceB, for: .normal)
            
        } else {
            userAnswerTextField.isHidden = true
            
            choiceAButton.setTitle(quizQuestions[question_number].choiceA, for: .normal)
            choiceBButton.setTitle(quizQuestions[question_number].choiceB, for: .normal)
            choiceCButton.setTitle(quizQuestions[question_number].choiceC, for: .normal)
            choiceDButton.setTitle(quizQuestions[question_number].choiceD, for: .normal)
            
        }
    }
    
    @IBAction func choiceAButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceAButton.titleLabel?.text?.prefix(2))!)
    }
    
    @IBAction func choiceBButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceBButton.titleLabel?.text?.prefix(2))!)
    }
    
    @IBAction func choiceCButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceCButton.titleLabel?.text?.prefix(2))!)
    }
    
    @IBAction func choiceDButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceDButton.titleLabel?.text?.prefix(2))!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        users_answers[question_number] = textField.text!
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if nextButton.titleLabel?.text == "Next" {
            question_number += 1
            changingQuestions()
        } else {
            // will submit quiz, call the user quiz results api call to enter users quiz score and call user question results api call to enter users answers, segue to quiz results page
            self.performSegue(withIdentifier: "quizToQuizResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizToQuizResultsSegue" && segue.destination is QuizResultsViewController {
            if let vc = segue.destination as? QuizResultsViewController {
                vc.user = self.user
                vc.quiz = self.quiz
                vc.quiz_iteration = self.quiz_iteration
                vc.quizQuestions = self.quizQuestions
                vc.usersAnswers = self.users_answers
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if question_number != 0 {
            question_number -= 1
            changingQuestions()
        }
    }
}
