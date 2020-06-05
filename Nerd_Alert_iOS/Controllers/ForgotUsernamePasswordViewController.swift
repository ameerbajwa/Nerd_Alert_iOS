//
//  ForgotUsernamePasswordViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 6/4/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit
import MessageUI

class ForgotUsernamePasswordViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    var forgot: String?
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendEmailButton.xibViewDisplayButtonDesign(button: sendEmailButton)
        
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
            
            DispatchQueue.main.async {
                if let userInfo = user_info {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients(["\(self.emailTextField.text!)"])
                    mail.setSubject("Nerd Alert Message - Retrieval of forgotten username/password")
                    mail.setMessageBody("Username: \(userInfo.username) Password: \(userInfo.password) Now don't forget it!", isHTML: false)
                }
            }

            
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
