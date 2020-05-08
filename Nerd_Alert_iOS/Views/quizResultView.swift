//
//  quizResultView.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/6/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class quizResultView: UIView {
    
    var numberButton: UIButton!
    var scoreLabel: UILabel!
    
    @IBOutlet weak var quizNumberButton: UIButton!
    @IBOutlet weak var quizScoreLabel: UILabel!
    
    override func awakeFromNib() {
        // programmatically design and edit labels and buttons
        print("awakeFromNib function being invoked")
        quizNumberButton = numberButton
        quizScoreLabel = scoreLabel
    }
    
}
