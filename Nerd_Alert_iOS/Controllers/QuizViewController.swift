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
    @IBOutlet weak var goBackHomeButton: UIButton!
    @IBOutlet weak var choiceAButton: UIButton!
    @IBOutlet weak var choiceBButton: UIButton!
    @IBOutlet weak var choiceCButton: UIButton!
    @IBOutlet weak var choiceDButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
//    @IBOutlet weak var backButton: UIButton!
    
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
    var user: User?
    
    var error: Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        self.choiceAButton.layer.cornerRadius = 10
        self.choiceAButton.layer.borderWidth = 3
        self.choiceBButton.layer.cornerRadius = 10
        self.choiceBButton.layer.borderWidth = 3
        self.choiceCButton.layer.cornerRadius = 10
        self.choiceCButton.layer.borderWidth = 3
        self.choiceDButton.layer.cornerRadius = 10
        self.choiceDButton.layer.borderWidth = 3
        
        self.quizNameLabel.text = "Quiz: \(self.quiz_name!)"
        
        quizQuestionService.retrieveQuizQuestions(quiz_id!, user!.id, "Taking_Quiz", onSuccess: { (response) in
            print("From Swift Application: retrieveQuizQuestions function called")
            print(response.count)
            
            if response.count == 1 {
                self.error = Error(json: response)
                self.quizQuestion.text = self.error?.error_message
                
                self.quizIterationLabel.isHidden = true
                self.quizQuestionNumberLabel.isHidden = true
                self.choiceAButton.isHidden = true
                self.choiceBButton.isHidden = true
                self.choiceCButton.isHidden = true
                self.choiceDButton.isHidden = true
                self.userAnswerTextField.isHidden = true
                self.nextButton.isHidden = true
                
            } else {
                
                DispatchQueue.main.async {
                    self.goBackHomeButton.isHidden = true
                }
                
                for i in response.keys {
                    self.question = QuizQuestion(json: response[i] as! [String : Any])
                    self.quizQuestions.append(self.question!)
                }
                
                DispatchQueue.main.async {
                    
                    self.quizResultsService.retrieveQuizIteration(self.user!.id, self.quiz_id!, onSuccess: { (response) in
                        print("From Swift Application: retrieveQuizIteration function called")
                        print(response)
                        self.quiz_iteration = response["iteration"] as! Int
                        
                        DispatchQueue.main.async {
                            self.changingQuestions()
                        }
                        
                    }, onFailure: { (error) in
                        print("From Swift Application: retrieveQuizIteration function called and an error occured")
                        print(error)
                    })
                }
                
            }
            
        }, onFailure: { (error) in
            print("From Swift Application: retrieveQuizzes function called and an error occured")
            print(error)
        })
        
    }
    
    func changingQuestions() {
        
        choiceAButton.isSelected = false
        choiceBButton.isSelected = false
        choiceCButton.isSelected = false
        choiceDButton.isSelected = false
        
        if question_number == 9 {
            nextButton.setTitle("Submit Quiz", for: .normal)
        }
        
        quizQuestionNumberLabel.text = "Question #\(question_number+1)"
        quizQuestion.text = quizQuestions[question_number].question
        
        if quizQuestions[question_number].choiceA == "BLANK" && quizQuestions[question_number].choiceB == "BLANK" && quizQuestions[question_number].choiceC == "BLANK" && quizQuestions[question_number].choiceD == "BLANK" {
            choiceAButton.isHidden = true
            choiceBButton.isHidden = true
            choiceCButton.isHidden = true
            choiceDButton.isHidden = true
            userAnswerTextField.isHidden = false
            
        } else if quizQuestions[question_number].choiceC == "BLANK" && quizQuestions[question_number].choiceD == "BLANK" {
            choiceAButton.isHidden = false
            choiceBButton.isHidden = false
            choiceCButton.isHidden = true
            choiceDButton.isHidden = true
            userAnswerTextField.isHidden = true
            
            choiceAButton.setTitle(quizQuestions[question_number].choiceA, for: .normal)
            choiceBButton.setTitle(quizQuestions[question_number].choiceB, for: .normal)
            
        } else {
            choiceAButton.isHidden = false
            choiceBButton.isHidden = false
            choiceCButton.isHidden = false
            choiceDButton.isHidden = false
            userAnswerTextField.isHidden = true
            
            choiceAButton.setTitle(quizQuestions[question_number].choiceA, for: .normal)
            choiceBButton.setTitle(quizQuestions[question_number].choiceB, for: .normal)
            choiceCButton.setTitle(quizQuestions[question_number].choiceC, for: .normal)
            choiceDButton.setTitle(quizQuestions[question_number].choiceD, for: .normal)
            
        }
    }
    
    @IBAction func choiceAButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceAButton.titleLabel?.text?.prefix(2))!)
        choiceAButton.isSelected = true
        choiceBButton.isSelected = false
        choiceCButton.isSelected = false
        choiceDButton.isSelected = false
    }
    
    @IBAction func choiceBButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceBButton.titleLabel?.text?.prefix(2))!)
        choiceBButton.isSelected = true
        choiceAButton.isSelected = false
        choiceCButton.isSelected = false
        choiceDButton.isSelected = false
    }
    
    @IBAction func choiceCButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceCButton.titleLabel?.text?.prefix(2))!)
        choiceCButton.isSelected = true
        choiceBButton.isSelected = false
        choiceAButton.isSelected = false
        choiceDButton.isSelected = false
    }
    
    @IBAction func choiceDButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceDButton.titleLabel?.text?.prefix(2))!)
        choiceDButton.isSelected = true
        choiceBButton.isSelected = false
        choiceCButton.isSelected = false
        choiceAButton.isSelected = false
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if nextButton.titleLabel?.text == "Next" {
            if userAnswerTextField.isHidden == false {
                users_answers[question_number] = userAnswerTextField.text
                userAnswerTextField.text = ""
            }
            question_number += 1
            DispatchQueue.main.async {
                self.changingQuestions()
            }
        } else {
            // will submit quiz, call the user quiz results api call to enter users quiz score and call user question results api call to enter users answers, segue to quiz results page
            if userAnswerTextField.isHidden == false {
                users_answers[question_number] = userAnswerTextField.text
                userAnswerTextField.text = ""
            }
            self.performSegue(withIdentifier: "quizToQuizResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizToQuizResultsSegue" && segue.destination is QuizResultsViewController {
            if let vc = segue.destination as? QuizResultsViewController {
                vc.user = self.user!
                vc.quiz_id = self.quiz_id
                vc.quiz_name = self.quiz_name
                vc.quiz_iteration = self.quiz_iteration
                vc.quizQuestions = self.quizQuestions
                vc.usersAnswers = self.users_answers
            }
        }
    }
    
    @IBAction func goBackHomeButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
