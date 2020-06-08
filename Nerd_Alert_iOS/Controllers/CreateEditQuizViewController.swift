//
//  CreateQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/9/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateEditQuizViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var quizNameTextView: UITextView!
    @IBOutlet weak var titleOfSourceTextView: UITextView!
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var quizDescriptionTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var quizActionButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var user: User?
    var action: String?
    var quizId: Int?
    var referenceBackToHomePageViewController: String = "Quiz Details"
    
    var quiz: Quiz?
    
    var quizService = QuizService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.setupToHideKeyboardOnTapOnView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        quizNameTextView.creatingPresentableTextFields(textView: quizNameTextView)
        titleOfSourceTextView.creatingPresentableTextFields(textView: titleOfSourceTextView)
        sourceTextView.creatingPresentableTextFields(textView: sourceTextView)
        quizDescriptionTextView.creatingPresentableTextFields(textView: quizDescriptionTextView)
        
        quizActionButton.simpleButtonDesign(button: quizActionButton)
        cancelButton.simpleButtonDesign(button: cancelButton)

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
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "CreateEditQuizToHomePage", sender: nil)
    }
    
    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
        
        if action == "Edit" {
            // API call to update quiz with quiz_id! with the new textfield
            
            if let quiz_id = quizId {
                quizService.reviseQuiz(quiz_name: quizNameTextView.text!, quiz_description: quizDescriptionTextView.text!, source: sourceTextView.text!, title_of_source: titleOfSourceTextView.text!, quiz_id: quiz_id, onSuccess: { (response) in
                    print("reviseQuiz API call to PUT a new quiz to the database was successful")
                    print(response)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "CreateEditQuizToHomePage", sender: nil)
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
                    self.performSegue(withIdentifier: "CreateEditQuizToHomePage", sender: nil)
                }
                
            }, onFailure: { (error) in
                print("injectQuiz API call was unsuccessful")
                print(error)
                
            })
        }
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateEditQuizToHomePage" && segue.destination is HomePageViewController {
            if let vc = segue.destination as? HomePageViewController {
                vc.changingQuizId = quizId!
                vc.referenceBackToHomePageViewController = referenceBackToHomePageViewController
            }
        }
    }
    
    
}
