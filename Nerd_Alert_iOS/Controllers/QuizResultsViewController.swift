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
    var quiz_iteration: Int?
    
    var quizQuestionsResultsService = QuizQuestionsResultsService()
    var quizResultsService = QuizResultsService()
    
    var quizQuestionsResults: [QuizQuestionsResults] = []
    var quizResults: QuizResults?
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for i in 0...9 {
            quizQuestionsResults[i].userId = user!.id
            quizQuestionsResults[i].quizId = quiz!.id
            quizQuestionsResults[i].quizIteration = quiz_iteration!
            quizQuestionsResults[i].questionId = quizQuestions[i].id
            quizQuestionsResults[i].userAnswer = usersAnswers[i]!!
            quizQuestionsResults[i].correctAnswer = quizQuestions[i].correctAnswer
            
            if usersAnswers[i]!! == quizQuestions[i].correctAnswer {
                score += 1
            }
            
        }
        
        print("Quiz Question Results")
        print(quizQuestionsResults)
        
        quizResultsService.injectQuizResult(user!.id, quiz!.id, score, onSuccess: { (response) in
            print("Successfully entered user's score for this quiz")
            print(response)
            
            self.usernameLabel.text = "\(self.user!.username) received"
            self.scoreLabel.text = "\(self.score)/10"
            self.quizNameLabel.text = "on \(self.quiz!.name) quiz"
            
            DispatchQueue.main.async{
                self.quizQuestionsResultsService.injectQuizQuestionsResults(self.quizQuestionsResults, onSuccess: { (response) in
                    print("Successfully enterd user's answers to each question for this quiz")
                }, onFailure: { (error) in
                    print("Error in injecting users' answers for this quiz \(self.quiz!.name)")
                    print(error)
                })
            }
            
        }, onFailure: { (error) in
            print("Error in injecting quiz result for user \(self.user!.username)")
            print(error)
        })
        
        
    }
    
    @IBAction func backToHomeButtonPressed(_ sender: UIButton) {
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
