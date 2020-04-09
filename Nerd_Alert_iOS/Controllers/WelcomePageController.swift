//
//  ViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/1/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class WelcomePageController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Welcome to the Nerd Alert App! Find out if your a big ole nerd or some who doesn't have a clue from all these different quizzes!")
        // Do any additional setup after loading the view.
        
        logInButton.layer.cornerRadius = 10
        logInButton.layer.borderWidth = 3
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
        
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        print("Going to Log In Page")
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        print("Going to Sign Up Page")
    }
    

}

