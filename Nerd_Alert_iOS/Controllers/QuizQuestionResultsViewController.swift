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
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var quiz_id: Int?
    var user_id: Int?
    var quiz_iteration: Int?
    
    var quizQuestionResultsService = QuizQuestionsResultsService()
    var quizQuestionService = QuizQuestionSerivce()
    
    var quizQuestionResult: QuizQuestionsResults?
    var quizQuestionResults: [String: Any] = [:]
    var questionIds: [String] = []
    var questionNumber: Int = 0
    
    var quizQuestions: [String: Any] = [:]
    var referenceBackToHomePageViewController: String = "My Quiz Results"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        nextButton.setTitle("Next", for: .normal)
        
        homeButton.simpleButtonDesign(button: homeButton, borderWidth: 0)
        nextButton.simpleButtonDesign(button: nextButton, borderWidth: 0)
        backButton.simpleButtonDesign(button: backButton, borderWidth: 0)
        
        backButton.isHidden = true

        quizQuestionResultsService.retrieveQuizQuestionsResults(user_id!, quiz_id!, quiz_iteration!, onSuccess: { (response) in
            print("retrieveQuizQuestionsResults API call successful")
            print(response.count)
            
            for i in response.keys {
                self.quizQuestionResult = QuizQuestionsResults(json: response[i] as! [String : Any])
                self.questionIds.append(self.quizQuestionResult!.questionId)
//                self.quizQuestionResults.append(self.quizQuestionResult!)
            }
            self.quizQuestionResults = response
            
            DispatchQueue.main.async {
                self.quizQuestionService.retrieveQuizQuestionsBasedOnIds(question_ids: self.questionIds, onSuccess: { (response) in
                    print("retrieveQuizQuestionsBasedOnIds API call successful")
                    print(response.count)
                    
                    self.quizQuestions = response
                    DispatchQueue.main.async {
                        self.changingQuestions()
                    }
                    
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
    
    func changingLabelColors(answer: String, color: UIColor, information: [String: Any]) {
        switch information[answer] as? String {
        case "A.":
            choiceALabel.backgroundColor = color
        case "B.":
            choiceBLabel.backgroundColor = color
        case "C.":
            choiceCLabel.backgroundColor = color
        case "D.":
            choiceDLabel.backgroundColor = color
        default:
            choiceALabel.backgroundColor = UIColor.white
            choiceBLabel.backgroundColor = UIColor.white
            choiceCLabel.backgroundColor = UIColor.white
            choiceDLabel.backgroundColor = UIColor.white
        }
    }
    
    func changingQuestions() {
        
        quizNumberLabel.text = "Quiz #\(quiz_iteration!)"
        questionNumberLabel.text = "Question #\(questionNumber+1)"
        
        let question_info = quizQuestions[questionIds[questionNumber]]! as! [String: Any]
        let user_question_info = quizQuestionResults[questionIds[questionNumber]]! as! [String: Any]
        
        questionLabel.text = question_info["question"] as? String
        choiceALabel.text = question_info["choice_A"] as? String
        choiceBLabel.text = question_info["choice_B"] as? String
        choiceCLabel.text = question_info["choice_C"] as? String
        choiceDLabel.text = question_info["choice_D"] as? String
        
        choiceALabel.backgroundColor = UIColor.white
        choiceBLabel.backgroundColor = UIColor.white
        choiceCLabel.backgroundColor = UIColor.white
        choiceDLabel.backgroundColor = UIColor.white

        if question_info["correct_answer"] as? String == user_question_info["user_answer"] as? String {
            changingLabelColors(answer: "correct_answer", color: UIColor.green, information: question_info)
        } else {
            changingLabelColors(answer: "correct_answer", color: UIColor.green, information: question_info)
            changingLabelColors(answer: "user_answer", color: UIColor.red, information: user_question_info)
        }
        
        if questionNumber == 9 {
            nextButton.setTitle("Finish", for: .normal)
        }
        
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "quizQuestionResultsViewControllerToHomePageViewController", sender: nil)
//        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        questionNumber -= 1
        changingQuestions()

        if questionNumber == 0 {
            backButton.isHidden = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        backButton.isHidden = false
        if questionNumber < 9 {
            questionNumber += 1
            changingQuestions()
        } else {
            self.performSegue(withIdentifier: "quizQuestionResultsViewControllerToHomePageViewController", sender: nil)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizQuestionResultsViewControllerToHomePageViewController" && segue.destination is HomePageViewController {
            if let vc = segue.destination as? HomePageViewController {
                vc.changingQuizId = quiz_id!
                vc.changingQuizIteration = quiz_iteration!
                vc.referenceBackToHomePageViewController = referenceBackToHomePageViewController
            }
        }
    }
    
}
