//
//  EditQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/11/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class EditQuizViewController: UIViewController {
    
    var quiz_id: Int?
    var user_id: Int?
    
    var quizService = QuizService()
    var quizQuestionService = QuizQuestionSerivce()

    override func viewDidLoad() {
        super.viewDidLoad()

        quizService.retreiveQuiz(quiz_id!, onSuccess: { (response) in
            print("retrieveQuiz API call succesful for editing quiz")
            print(response)
            
            DispatchQueue.main.async {
                self.quizQuestionService.retrieveQuizQuestions(self.quiz_id!, self.user_id!, onSuccess: { (response) in
                    print("retrieveQuizQuestions API call succesful for editing quiz")
                    print(response.count)
                    
                    
                }, onFailure: { (error) in
                    print("error in retrieveQuizQuestions API call")
                    print(error)
                })
            }
            
        }, onFailure: { (error) in
            print("error in retrieveQuiz API call")
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

}
