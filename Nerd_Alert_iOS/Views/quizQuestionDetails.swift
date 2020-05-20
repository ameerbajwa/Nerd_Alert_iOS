//
//  quizQuestionDetails.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/20/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

@objc protocol actionsFromQuizQuestionDetailsDelegate {
    func goToCreateEditQuestionScreen()
}

class quizQuestionDetails: UIView {
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet var delegate: actionsFromQuizQuestionDetailsDelegate?
    
    override class func awakeFromNib() {
        // la di da
    }
    
    func quizQuestionDetailsXibInit() {
        
    }
    
    
    @IBAction func addQuestionButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func editQuestionButtonPressed(_ sender: UIButton) {
    }
    
}
