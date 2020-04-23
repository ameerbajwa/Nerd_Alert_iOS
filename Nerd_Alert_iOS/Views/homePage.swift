//
//  homePage.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

@objc protocol retrieveQuizzesDelegate {
    func retrievingQuizzes(users_quizzes: Bool)
}

class homePage: UIView {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var quizActionButton: UIButton!
    @IBOutlet var delegate: retrieveQuizzesDelegate?
    
    override func awakeFromNib() {
        // programmatically design and edit labels and buttons
        print("awakeFromNib function being invoked")
    }
    
    func homePageXibInit(username: String) {
        usernameLabel.text = "Home of \(username)"
        changingButtonTitles()
    }
    
    func changingButtonTitles() {
        if usersQuizzesInstance.usersQuizzes == true { // users_quizzes == true
            quizActionButton.setTitle("View Quizzes", for: .normal)
        } else {
            quizActionButton.setTitle("View My Quizzes", for: .normal)
        }
    }
    
    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
        usersQuizzesInstance.usersQuizzes = !usersQuizzesInstance.usersQuizzes
        changingButtonTitles()
        self.delegate?.retrievingQuizzes(users_quizzes: usersQuizzesInstance.usersQuizzes)
    }
    
    @IBAction func createQuizButtonPressed(_ sender: UIButton) {
    }
    
    
}
