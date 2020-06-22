//
//  ForgotUsernamePasswordViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 6/4/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit
import MessageUI

class ForgotUsernamePasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    var forgot: String?
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendEmailButton.simpleButtonDesign(button: sendEmailButton, borderWidth: 0)
        
        if forgot == "username" {
            usernameLabel.isHidden = true
            usernameTextField.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendEmailButtonPressed(_ sender: UIButton) {
        
        userService.retrieveUserForgottenInfo(email: emailTextField.text!, onSuccess: { (response) in
            print("retrieveUserForgottenInfo API call successful")
            print(response)
            
            let user_info: User?
            user_info = User(json: response)
            
        }, onFailure: { (error) in
            print("ERROR retrieveUserForgottenInfo API call unsuccessful")
            print(error)
        })
        

    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forgotUsernamePasswordToLogInSegue" && segue.destination is LogInController {
            if let vc = segue.destination as? LogInController {
                
            }
        }
    }

}
