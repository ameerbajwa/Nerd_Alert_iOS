//
//  quizDetails.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

@objc protocol homePageViewDelegate {
    func gettingHomePageView()
}

class quizDetails: UIView {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleOfSourceLabel: UILabel!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var takeQuizButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var delegate: homePageViewDelegate?
        
    override class func awakeFromNib() {
        // change any label, button viewing
    }

    func quizDetailsXibInit(quiz_name: String, created_by: String, description: String, source: String, title_of_source: String, score: String, username: String?) {
        quizNameLabel.text = quiz_name
        createdByLabel.text = "Created By: \(created_by)"
        quizDescriptionLabel.text = description
        sourceLabel.text = "Source: \(source)"
        titleOfSourceLabel.text = title_of_source
        
        if username == created_by {
            scoreLabel.isHidden = true
            takeQuizButton.setTitle("Edit Quiz", for: .normal)
        } else {
            if score != "" {
                scoreLabel.isHidden = false
                takeQuizButton.isHidden = true
             } else {
                scoreLabel.isHidden = true
                takeQuizButton.setTitle("Take Quiz", for: .normal)
                takeQuizButton.isHidden = false
             }
            
        }
    }

    @IBAction func takeQuizButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func homePageButtonPressed(_ sender: UIButton) {
        print(usersQuizzesInstance.usersQuizzes)
        self.delegate?.gettingHomePageView()
    }
    
}
