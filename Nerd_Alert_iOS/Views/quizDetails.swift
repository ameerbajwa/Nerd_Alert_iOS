//
//  quizDetails.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

@objc protocol actionsFromQuizDetailsDelegate {
    func gettingHomePageView()
    func goToQuizPage(quiz_id: Int, quiz_name: String)
    func goToAddEditQuizQuestionsView(quiz_id: Int, quiz_name: String)
    func goToEditQuizPage(quiz_id: Int, action: String)
    func goToQuizResultsView(quiz_id: Int, quiz_name: String)
}

class quizDetails: UIView {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleOfSourceLabel: UILabel!
    @IBOutlet weak var numberOfQuestionsLabel: UILabel!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var quizActionButton: UIButton!
    @IBOutlet weak var secondaryQuizActionButton: UIButton!
    
    var quiz_id: Int?
        
    @IBOutlet var delegate: actionsFromQuizDetailsDelegate?
    
//    @IBOutlet var delegate: homePageViewDelegate?
//    @IBOutlet var quizDelegate: goToQuizPageDelegate?
        
    override class func awakeFromNib() {
        // change any label, button viewing
    }

    func quizDetailsXibInit(quizId: Int, quiz_name: String, created_by: String, description: String, source: String, title_of_source: String, username: String?, numberOfQuestions: Int) {
        quizNameLabel.text = quiz_name
        createdByLabel.text = "Created By: \(created_by)"
        quizDescriptionLabel.text = description
        sourceLabel.text = "Source: \(source)"
        titleOfSourceLabel.text = "Title of Source: \(title_of_source)"
        numberOfQuestionsLabel.text = "Number of Questions: \(numberOfQuestions)"
        
        homePageButton.simpleButtonDesign(button: homePageButton)
        secondaryQuizActionButton.simpleButtonDesign(button: secondaryQuizActionButton)
        quizActionButton.simpleButtonDesign(button: quizActionButton)
        
        quiz_id = quizId
        
        if username == created_by {
            quizActionButton.setTitle("Add/Edit Quiz Questions", for: .normal)
            secondaryQuizActionButton.setTitle("Edit Quiz Details", for: .normal)
        } else {
            quizActionButton.setTitle("Take Quiz", for: .normal)
            secondaryQuizActionButton.setTitle("View Quiz Results", for: .normal)
        }

    }

    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
        if quiz_id != nil {
            if quizActionButton.titleLabel?.text == "Add/Edit Quiz Questions" { // usersQuizzesInstance.usersQuizzes == true
                print("edit quiz: \(quizNameLabel.text!)")
                self.delegate?.goToAddEditQuizQuestionsView(quiz_id: quiz_id!, quiz_name: quizNameLabel.text!)
            } else if quizActionButton.titleLabel?.text == "Take Quiz" {
                print("taking quiz: \(quizNameLabel.text!)")
                self.delegate?.goToQuizPage(quiz_id: quiz_id!, quiz_name: quizNameLabel.text!)
            }

        }
    }
    
    @IBAction func homePageButtonPressed(_ sender: UIButton) {
        self.delegate?.gettingHomePageView()
    }
    
    @IBAction func secondaryQuizActionButtonPressed(_ sender: UIButton) {
        
        if secondaryQuizActionButton.titleLabel?.text == "Edit Quiz Details" {
            self.delegate?.goToEditQuizPage(quiz_id: quiz_id!, action: "Edit")
        } else if secondaryQuizActionButton.titleLabel?.text == "View Quiz Results" {
            self.delegate?.goToQuizResultsView(quiz_id: quiz_id!, quiz_name: quizNameLabel.text!)
        }

    }
}
