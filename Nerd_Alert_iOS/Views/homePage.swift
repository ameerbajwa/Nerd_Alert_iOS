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
    var users_quizzes: Bool = false
    
    override func awakeFromNib() {
        // programmatically design and edit labels and buttons
        print("awakeFromNib function being invoked")
        if users_quizzes == true {
            quizActionButton.setTitle("View Quizzes", for: .normal)
        } else {
            quizActionButton.setTitle("View My Quizzes", for: .normal)
        }
    }
    
    func homePageXibInit(username: String) {
        usernameLabel.text = "Home of \(username)"
    }
    
    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
        users_quizzes = !users_quizzes
        awakeFromNib()
        self.delegate?.retrievingQuizzes(users_quizzes: users_quizzes)
    }
    
    @IBAction func createQuizButtonPressed(_ sender: UIButton) {
    }
    
    
}
