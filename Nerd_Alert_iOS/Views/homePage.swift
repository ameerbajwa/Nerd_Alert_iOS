//
//  homePage.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

@objc protocol homePageDelegate {
    func retrievingQuizzes(users_quizzes: Bool)
    func createQuiz(action: String)
}

class homePage: UIView {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var quizControl: UISegmentedControl!
//    @IBOutlet weak var quizActionButton: UIButton!
    @IBOutlet weak var createQuizButton: UIButton!
    @IBOutlet var delegate: homePageDelegate?
    
    override func awakeFromNib() {
        // programmatically design and edit labels and buttons
        print("awakeFromNib function being invoked")
    }
    
    func homePageXibInit(username: String) {
        usernameLabel.text = "Home of \(username)"
        quizControl.setTitle("Quizzes", forSegmentAt: 0)
        quizControl.setTitle("My Quizzes", forSegmentAt: 1)
        
        createQuizButton.simpleButtonDesign(button: createQuizButton)
        
        if usersQuizzesInstance.usersQuizzes == true {
            quizControl.selectedSegmentIndex = 1
            quizControl.setEnabled(true, forSegmentAt: 1)
            createQuizButton.isHidden = false
        } else {
            quizControl.selectedSegmentIndex = 0
            quizControl.setEnabled(true, forSegmentAt: 0)
            createQuizButton.isHidden = true
        }
        
//        changingButtonTitles()
        
//        if usersQuizzesInstance.usersQuizzes == true {
//            createQuizButton.isHidden = true
//        } else {
//            createQuizButton.isHidden = false
//        }
    }
    
//    func changingButtonTitles() {
//        if usersQuizzesInstance.usersQuizzes == true { // users_quizzes == true
//            quizActionButton.setTitle("View Quizzes", for: .normal)
//            createQuizButton.isHidden = false
//        } else {
//            quizActionButton.setTitle("View My Quizzes", for: .normal)
//            createQuizButton.isHidden = true
//        }
//    }
    
    @IBAction func quizControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            usersQuizzesInstance.usersQuizzes = false
            self.delegate?.retrievingQuizzes(users_quizzes: usersQuizzesInstance.usersQuizzes)
            createQuizButton.isHidden = true
        case 1:
            usersQuizzesInstance.usersQuizzes = true
            self.delegate?.retrievingQuizzes(users_quizzes: usersQuizzesInstance.usersQuizzes)
            createQuizButton.isHidden = false
        default:
            break
        }
    }
    
//    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
//        usersQuizzesInstance.usersQuizzes = !usersQuizzesInstance.usersQuizzes
//        changingButtonTitles()
//        self.delegate?.retrievingQuizzes(users_quizzes: usersQuizzesInstance.usersQuizzes)
//    }
    
    @IBAction func createQuizButtonPressed(_ sender: UIButton) {
        self.delegate?.createQuiz(action: "Create")
    }
    
    
}
