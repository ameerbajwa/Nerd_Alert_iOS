//
//  quizDetails.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/19/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class quizDetails: UIView {
    
    @IBOutlet var quizDetailsView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "quizDetails", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(quizDetailsView)
        quizDetailsView.frame = self.bounds
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
