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
    func goToQuizResults(quiz_id: Int, quiz_name: String)
}

class quizDetails: UIView {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleOfSourceLabel: UILabel!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var takeQuizButton: UIButton!
    
    var quiz_id: Int?
    
    @IBOutlet var delegate: actionsFromQuizDetailsDelegate?
    
//    @IBOutlet var delegate: homePageViewDelegate?
//    @IBOutlet var quizDelegate: goToQuizPageDelegate?
        
    override class func awakeFromNib() {
        // change any label, button viewing
    }

    func quizDetailsXibInit(quizId: Int, quiz_name: String, created_by: String, description: String, source: String, title_of_source: String, username: String?) {
        quizNameLabel.text = quiz_name
        createdByLabel.text = "Created By: \(created_by)"
        quizDescriptionLabel.text = description
        sourceLabel.text = "Source: \(source)"
        titleOfSourceLabel.text = title_of_source
        quiz_id = quizId
        
        takeQuizButton.setTitle("Take Quiz", for: .normal)
        
        if username == created_by {
            takeQuizButton.setTitle("Edit Quiz", for: .normal)
        }
//        else {
//            if score != "" {
//                scoreLabel.isHidden = false
//                takeQuizButton.isHidden = true
//             } else {
//                scoreLabel.isHidden = true
//                takeQuizButton.setTitle("Take Quiz", for: .normal)
//                takeQuizButton.isHidden = false
//             }
//        }
    }

    @IBAction func takeQuizButtonPressed(_ sender: UIButton) {
        if quiz_id != nil {
            print("taking quiz: \(quizNameLabel.text!)")
            self.delegate?.goToQuizPage(quiz_id: quiz_id!, quiz_name: quizNameLabel.text!)
        }
    }
    
    @IBAction func homePageButtonPressed(_ sender: UIButton) {
        self.delegate?.gettingHomePageView()
    }
    
    @IBAction func viewResultsButtonPressed(_ sender: UIButton) {
        self.delegate?.goToQuizResults(quiz_id: quiz_id!, quiz_name: quizNameLabel.text!)
    }
}
