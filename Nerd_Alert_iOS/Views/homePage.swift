//
//  homePage.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class homePage: UIView {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var quizActionButton: UIButton!
    
    override func awakeFromNib() {
        // programmatically design and edit labels and buttons
    }
    
    func homePageXibInit(username: String) {
        usernameLabel.text = "Home of \(username)"
    }
    
    @IBAction func quizActionButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func createQuizButtonPressed(_ sender: UIButton) {
    }
    
    
}
