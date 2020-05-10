//
//  CreateQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/9/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateQuizViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quizNameTextField: UITextField!
    @IBOutlet weak var titleOfSourceTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var quizDescriptionTextField: UITextField!
    
    var user: User?
    var quizService = QuizService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func submitQuizButtonPressed(_ sender: UIButton) {
        
        quizService.injectQuiz(quiz_name: quizNameTextField.text!, source: sourceTextField.text!, title_of_source: titleOfSourceTextField.text!, createdBy: user!.username, createdBy_user_id: user!.id, onSuccess: { (response) in
            print("injectQuiz API call to POST a new quiz to the database was successful")
            print(response)
            
        }, onFailure: { (error) in
            print("injectQuiz API call was unsuccessful")
            print(error)
            
        })
    }
    
}
