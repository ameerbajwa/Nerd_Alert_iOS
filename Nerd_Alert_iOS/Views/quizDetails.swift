//
//  quizDetails.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class quizDetails: UIView {

    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleOfSourceLabel: UILabel!
    @IBOutlet weak var takeQuizButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        UINib(nibName: "quizDetails", bundle: nil).instantiate(withOwner: self, options: nil)
//        addSubview(quizDetailsView)
//        quizDetailsView.frame = self.bounds
//    }
    
    override class func awakeFromNib() {
        // change any label, button viewing
    }

    func quizDetailsXibInit(quiz_name: String, created_by: String, description: String, source: String, title_of_source: String, score: String) {
        quizNameLabel.text = quiz_name
        createdByLabel.text = "Created By: \(created_by)"
        quizDescriptionLabel.text = description
        sourceLabel.text = "Source: \(source)"
        titleOfSourceLabel.text = title_of_source
        if score != "" {
            takeQuizButton.isHidden = true
            scoreLabel.text = "Score: \(score)/10"
        } else {
            scoreLabel.isHidden = true
        }
    }

    @IBAction func takeQuizButtonPressed(_ sender: UIButton) {
    }
}
