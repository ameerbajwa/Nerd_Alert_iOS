//
//  QuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/23/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var quizIterationLabel: UILabel!
    @IBOutlet weak var quizQuestionNumberLabel: UILabel!
    @IBOutlet weak var quizQuestion: UILabel!
    
    @IBOutlet weak var userAnswerTextField: UITextField!
    @IBOutlet weak var choiceAButton: UIButton!
    @IBOutlet weak var choiceBButton: UIButton!
    @IBOutlet weak var choiceCButton: UIButton!
    @IBOutlet weak var choiceDButton: UIButton!
    
    
    var quiz_id: Int?
    var user_id: Int?
    
    var quizQuestionService = QuizQuestionSerivce()
    var quizQuestions: [QuizQuestion] = []
    var question: QuizQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("retreiving questions from quiz")
        quizQuestionService.retrieveQuizQuestions(quiz_id!, user_id!, onSuccess: { (response) in
            print("From Swift Application: retrieveQuizQuestions function called")
            print(response.count)
            
            for i in response.keys {
                self.question = QuizQuestion(json: response[i] as! [String : Any])
                self.quizQuestions.append(self.question!)
            }
            
        }, onFailure: { (error) in
            print("From Swift Application: retrieveQuizzes function called and an error occured")
            print(error)
        })
        
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
    }
}
