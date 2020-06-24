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
    
    var number_of_quiz_questions: Int?
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        nextButton.simpleButtonDesign(button: nextButton, borderWidth: 0)
        choiceAButton.simpleButtonDesign(button: choiceAButton, borderWidth: 3)
        choiceBButton.simpleButtonDesign(button: choiceBButton, borderWidth: 3)
        choiceCButton.simpleButtonDesign(button: choiceCButton, borderWidth: 3)
        choiceDButton.simpleButtonDesign(button: choiceDButton, borderWidth: 3)
        
        self.quizNameLabel.text = "Quiz: \(self.quiz_name!)"
        
        if number_of_quiz_questions! != 0 {
            quizQuestionService.retrieveQuizQuestions(quiz_id!, user!.id, "Taking_Quiz", onSuccess: { (response) in
                print("From Swift Application: retrieveQuizQuestions function called")
                print(response.count)
                
                if response.count == 10 {
                    for i in response.keys {
                        self.question = QuizQuestion(json: response[i] as! [String : Any])
                        self.quizQuestions.append(self.question!)
                    }
                    
                    DispatchQueue.main.async {
                        self.goBackHomeButton.isHidden = true
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
                } else if response.count < 10 && response.count > 0 {
                    self.quizQuestion.text = "Quiz Creator needs to create more questions to create a complete quiz."
                    DispatchQueue.main.async {
                        self.userNotAbleToTakeQuiz()
                    }
                } else if response.count == 0 {
                    self.quizQuestion.text = "You have already answered all the questions of this quiz."
                    DispatchQueue.main.async {
                        self.userNotAbleToTakeQuiz()
                    }
                }
        
            }, onFailure: { (error) in
                print("From Swift Application: retrieveQuizzes function called and an error occured")
                print(error)
            })
        } else {
            self.quizQuestion.text = "No questions are available to answer for this quiz right now."
            DispatchQueue.main.async {
                self.userNotAbleToTakeQuiz()
            }
            
        }
    }
    
    func userNotAbleToTakeQuiz() {
        goBackHomeButton.simpleButtonDesign(button: goBackHomeButton, borderWidth: 0)
        self.quizIterationLabel.isHidden = true
        self.quizQuestionNumberLabel.isHidden = true
        self.choiceAButton.isHidden = true
        self.choiceBButton.isHidden = true
        self.choiceCButton.isHidden = true
        self.choiceDButton.isHidden = true
        self.userAnswerTextField.isHidden = true
        self.nextButton.isHidden = true
    }
    
    func changingQuestions() {
        
        choiceAButton.backgroundColor = UIColor.clear
        choiceBButton.backgroundColor = UIColor.clear
        choiceCButton.backgroundColor = UIColor.clear
        choiceDButton.backgroundColor = UIColor.clear
        
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
        choiceAButton.backgroundColor = UIColor.lightGray
        choiceBButton.backgroundColor = UIColor.clear
        choiceCButton.backgroundColor = UIColor.clear
        choiceDButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func choiceBButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceBButton.titleLabel?.text?.prefix(2))!)
        choiceBButton.backgroundColor = UIColor.lightGray
        choiceAButton.backgroundColor = UIColor.clear
        choiceCButton.backgroundColor = UIColor.clear
        choiceDButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func choiceCButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceCButton.titleLabel?.text?.prefix(2))!)
        choiceCButton.backgroundColor = UIColor.lightGray
        choiceBButton.backgroundColor = UIColor.clear
        choiceAButton.backgroundColor = UIColor.clear
        choiceDButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func choiceDButtonPressed(_ sender: UIButton) {
        users_answers[question_number] = String((choiceDButton.titleLabel?.text?.prefix(2))!)
        choiceDButton.backgroundColor = UIColor.lightGray
        choiceBButton.backgroundColor = UIColor.clear
        choiceCButton.backgroundColor = UIColor.clear
        choiceAButton.backgroundColor = UIColor.clear
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
