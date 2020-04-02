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
        // Do any additional setup after loading the view.
        
        logInButton.layer.cornerRadius = 10
        logInButton.layer.borderWidth = 3
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
        
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
    }
    

}

