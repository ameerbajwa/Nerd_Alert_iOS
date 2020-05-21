//
//  EditQuizViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/11/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class CreateEditQuizQuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var choiceATextField: UITextField!
    @IBOutlet weak var choiceBTextField: UITextField!
    @IBOutlet weak var choiceCTextField: UITextField!
    @IBOutlet weak var choiceDTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var quiz_id: Int?
    var user_id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
    }
}
