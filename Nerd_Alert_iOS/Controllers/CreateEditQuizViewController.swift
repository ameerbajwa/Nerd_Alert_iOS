//
//  CreateQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/9/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateEditQuizViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quizNameTextField: UITextField!
    @IBOutlet weak var titleOfSourceTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var quizDescriptionTextField: UITextField!
    @IBOutlet weak var quizActionButton: UIButton!
    
    var user: User?
    var action: String?
    var quizId: Int?
    
    var quiz: Quiz?
    
    var quizService = QuizService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if action == "Edit" {
            if let quiz_id = quizId {
                quizService.retreiveQuiz(quiz_id, onSuccess: { (response) in
                    print("retreiveQuiz API call was successful")
                    print(response)
                    
                    self.quiz = Quiz(json: response)
                    
                    DispatchQueue.main.async {
                        if let selectedQuiz = self.quiz {
                            self.quizNameTextField.text = selectedQuiz.name
                            self.titleOfSourceTextField.text = selectedQuiz.titleOfSource
                            self.sourceTextField.text = selectedQuiz.source
                            self.quizDescriptionTextField.text = selectedQuiz.description
                        }
                    }
                    
                }, onFailure: { (error) in
                    print("retreiveQuiz API call was unsuccessful")
                    print(error)
                })
            }
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
        
        if action == "Edit" {
            // API call to update quiz with quiz_id! with the new textfield
            
            if let quiz_id = quizId {
                quizService.reviseQuiz(quiz_name: quizNameTextField.text!, quiz_description: quizDescriptionTextField.text!, source: sourceTextField.text!, title_of_source: titleOfSourceTextField.text!, quiz_id: quiz_id, onSuccess: { (response) in
                    print("reviseQuiz API call to PUT a new quiz to the database was successful")
                    print(response)
                    
                }, onFailure: { (error) in
                    print("reviseQuiz API call was unsuccessful")
                    print(error)
                    
                })
            }
            
        } else {
            quizService.injectQuiz(quiz_name: quizNameTextField.text!, quiz_description: quizDescriptionTextField.text!, source: sourceTextField.text!, title_of_source: titleOfSourceTextField.text!, createdBy: user!.username, createdBy_user_id: user!.id, onSuccess: { (response) in
                print("injectQuiz API call to POST a new quiz to the database was successful")
                print(response)
                
            }, onFailure: { (error) in
                print("injectQuiz API call was unsuccessful")
                print(error)
                
            })
        }
        

        
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
