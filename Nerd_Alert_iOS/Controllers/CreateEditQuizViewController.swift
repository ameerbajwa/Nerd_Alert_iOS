//
//  CreateQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/9/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateEditQuizViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quizNameTextView: UITextView!
    @IBOutlet weak var titleOfSourceTextView: UITextView!
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var quizDescriptionTextView: UITextView!
        
    @IBOutlet weak var quizActionButton: UIButton!
    
    var user: User?
    var action: String?
    var quizId: Int?
    
    var quiz: Quiz?
    
    var quizService = QuizService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        quizNameTextView.creatingPresentableTextFields(textView: quizNameTextView)
        titleOfSourceTextView.creatingPresentableTextFields(textView: titleOfSourceTextView)
        sourceTextView.creatingPresentableTextFields(textView: sourceTextView)
        quizDescriptionTextView.creatingPresentableTextFields(textView: quizDescriptionTextView)

        // Do any additional setup after loading the view.
        
        if action == "Edit" {
            if let quiz_id = quizId {
                quizService.retreiveQuiz(quiz_id, onSuccess: { (response) in
                    print("retreiveQuiz API call was successful")
                    print(response)
                    
                    self.quiz = Quiz(json: response)
                    
                    DispatchQueue.main.async {
                        if let selectedQuiz = self.quiz {
                            self.quizNameTextView.text = selectedQuiz.name
                            self.titleOfSourceTextView.text = selectedQuiz.titleOfSource
                            self.sourceTextView.text = selectedQuiz.source
                            self.quizDescriptionTextView.text = selectedQuiz.description
                            self.quizActionButton.setTitle("Save Quiz Details", for: .normal)
                        }
                    }
                    
                }, onFailure: { (error) in
                    print("retreiveQuiz API call was unsuccessful")
                    print(error)
                })
            }
        } else {
            quizActionButton.setTitle("Submit Quiz Details", for: .normal)
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
        
        if action == "Edit" {
            // API call to update quiz with quiz_id! with the new textfield
            
            if let quiz_id = quizId {
                quizService.reviseQuiz(quiz_name: quizNameTextView.text!, quiz_description: quizDescriptionTextView.text!, source: sourceTextView.text!, title_of_source: titleOfSourceTextView.text!, quiz_id: quiz_id, onSuccess: { (response) in
                    print("reviseQuiz API call to PUT a new quiz to the database was successful")
                    print(response)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }, onFailure: { (error) in
                    print("reviseQuiz API call was unsuccessful")
                    print(error)
                    
                })
            }
            
        } else {
            quizService.injectQuiz(quiz_name: quizNameTextView.text!, quiz_description: quizDescriptionTextView.text!, source: sourceTextView.text!, title_of_source: titleOfSourceTextView.text!, createdBy: user!.username, createdBy_user_id: user!.id, onSuccess: { (response) in
                print("injectQuiz API call to POST a new quiz to the database was successful")
                print(response)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
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
