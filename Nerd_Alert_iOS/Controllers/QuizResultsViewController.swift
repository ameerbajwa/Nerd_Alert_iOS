//
//  QuizResultsViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/25/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class QuizResultsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quizNameLabel: UILabel!
    
    var user: User?
    var quiz: Quiz?
    var quizQuestions: [QuizQuestion] = []
    var usersAnswers: [Int: String?] = [:]
    
    var quizQuestionsResults: [QuizQuestionsResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for i in 0...9 {
            quizQuestionsResults[i].userId = user!.id
            quizQuestionsResults[i].quizId = quiz!.id
            quizQuestionsResults[i].quizIteration = 1
            quizQuestionsResults[i].questionId = quizQuestions[i].id
            quizQuestionsResults[i].userAnswer = usersAnswers[i]!!
            quizQuestionsResults[i].correctAnswer = quizQuestions[i].correctAnswer
        }
        
        print("Quiz Question Results")
        print(quizQuestionsResults)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
