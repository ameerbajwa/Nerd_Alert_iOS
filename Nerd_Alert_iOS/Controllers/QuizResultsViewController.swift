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
    var quiz_id: Int?
    var quiz_name: String?
    var quiz_iteration: Int?
    var quizQuestions: [QuizQuestion] = []
    var usersAnswers: [Int: String?] = [:]
    
    var quizQuestionsResultsService = QuizQuestionsResultsService()
    var quizResultsService = QuizResultsService()
    
    var quizQuestionsResults: [QuizQuestionsResults] = []
    var quizQuestionResult: QuizQuestionsResults?
    var quizResults: QuizResults?
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        for i in 0...9 {
//            print(quizQuestions[i])
//            print(usersAnswers[i])
//        }
        
        for i in 0...9 {
            
            let quizQuestionResult = QuizQuestionsResults(json: ["user_id": user!.id,
                                                                 "quiz_id": quiz_id!,
                                                                 "question_id": quizQuestions[i].id,
                                                                 "quiz_iteration": quiz_iteration!,
                                                                 "user_answer": usersAnswers[i]!!,
                                                                 "correct_answer": quizQuestions[i].correctAnswer])

            quizQuestionsResults.append(quizQuestionResult)

            if usersAnswers[i]!! == quizQuestions[i].correctAnswer {
                score += 1
            }

        }

        print("Quiz Question Results")
        print(quizQuestionsResults)
        print(score)
        
        quizResultsService.injectQuizResult(user!.id, quiz_id!, quiz_iteration!, score, onSuccess: { (response) in
            print("Successfully entered user's score for this quiz")
            print(response)

            DispatchQueue.main.async{
                self.usernameLabel.text = "\(self.user!.username) received"
                self.scoreLabel.text = "\(self.score)/10"
                self.quizNameLabel.text = "on \(self.quiz_name!) quiz"
                
                self.quizQuestionsResultsService.injectQuizQuestionsResults(self.quizQuestionsResults, onSuccess: { (response) in
                    print("Successfully enterd user's answers to each question for this quiz")
                }, onFailure: { (error) in
                    print("Error in injecting users' answers for this quiz \(self.quiz_name!)")
                    print(error)
                })
            }

        }, onFailure: { (error) in
            print("Error in injecting quiz result for user \(self.user!.username)")
            print(error)
        })
        
    }
    
    @IBAction func backToHomeButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToHomePageSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHomePageSegue" && segue.destination is HomePageViewController {
            if let vc = segue.destination as? HomePageViewController {
                vc.user = user
                vc.quiz_id = quiz_id!
            }
        }
    }

}
