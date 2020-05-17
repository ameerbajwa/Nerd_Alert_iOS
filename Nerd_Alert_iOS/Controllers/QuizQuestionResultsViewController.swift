//
//  QuizQuestionResultsViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/16/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class QuizQuestionResultsViewController: UIViewController {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceALabel: UILabel!
    @IBOutlet weak var choiceBLabel: UILabel!
    @IBOutlet weak var choiceCLabel: UILabel!
    @IBOutlet weak var choiceDLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var quiz_id: Int?
    var user_id: Int?
    var quiz_iteration: Int?
    
    var quizQuestionResultsService = QuizQuestionsResultsService()
    var quizQuestionService = QuizQuestionSerivce()
    
    var quizQuestionResult: QuizQuestionsResults?
    var quizQuestionResults: [QuizQuestionsResults] = []
    var questionIds: [String] = []
    var quizQuestion: QuizQuestion?
    var quizQuestions: [QuizQuestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quizQuestionResultsService.retrieveQuizQuestionsResults(user_id!, quiz_id!, quiz_iteration!, onSuccess: { (response) in
            print("retrieveQuizQuestionsResults API call successful")
            print(response)
            
            for i in response.keys {
                self.quizQuestionResult = QuizQuestionsResults(json: response[i] as! [String : Any])
                self.questionIds.append(self.quizQuestionResult!.questionId)
                self.quizQuestionResults.append(self.quizQuestionResult!)
            }
            
            DispatchQueue.main.async {
                self.quizQuestionService.retrieveQuizQuestionsBasedOnIds(question_ids: self.questionIds, onSuccess: { (response) in
                    print("retrieveQuizQuestionsBasedOnIds API call successful")
                    print(response)
                }, onFailure: { (error) in
                    print("ERROR retrieveQuizQuestionsBasedOnIds API call unsuccessful")
                    print(error)
                })
            }
            
        }, onFailure: { (error) in
            print("ERROR retrieveQuizQuestionsResults API call unsuccessful")
            print(error)
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
}
