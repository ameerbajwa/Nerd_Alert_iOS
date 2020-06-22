//
//  LogInController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/2/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class LogInController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    let userService = UserService()
    var accessTokenJSON: [String: Any] = [:]
    var userInfo: User?
    var forgotAction: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupToHideKeyboardOnTapOnView()
        invalidLabel.textColor = UIColor.red
        invalidLabel.isHidden = true

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        logInButton.simpleButtonDesign(button: logInButton, borderWidth: 0)

    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        print("Log In Button Pressed")

        if usernameTextField.text != "" && passwordTextField.text != "" {
            // log in POST API CALL and user information GET API CALL

            userService.authenticateUser(usernameTextField.text!, passwordTextField.text!, onSuccess: { (response) -> Void in
                print("authenticateUser API called successfully")
                print(response)
                self.accessTokenJSON = response
                    
                DispatchQueue.main.async {
                    
                    if let accessToken = self.accessTokenJSON["access_token"] as? String {
                        self.userInfo?.accessToken = accessToken
                        
                        self.userService.retrieveUserInfo(self.usernameTextField.text!, onSuccess: { (response) -> Void in
                            print("retrieveUserInfo API called successfully")
                            print(response)

                            self.userInfo = User(json: response)
                            
                            print("user information obtained and ready to be segued to home page view controller")
                            print(self.userInfo!)
                            
                            if let id = self.userInfo?.id {
                                if id > 0 {
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "logInToHomePage", sender: self)
                                    }
                                } else {
                                    print("user has no id, could not return any information on user")
                                }
                            } else {
                                print("userInfo class has not been properly populated")
                            }

                        }) { (error) -> Void in
                            print("ERROR retrieveUserInfo API called unsuccessfully")
                            print(error)
                        }
                        
                    } else {
                        print("couldn't pass accessToken value to userInfo struct")
                        self.invalidLabel.isHidden = false
                    }
                }

            },
                onFailure: { (error) -> Void in
                    print("ERROR authenticateUser API called unsuccessfully")
                    print(error)
                    DispatchQueue.main.async {
                        self.invalidLabel.isHidden = false
                    }
                }
            )

        } else {
            // send error message all textfields need to be filled out
            print("Need to fill out username and password textfields")
            DispatchQueue.main.async {
                self.invalidLabel.isHidden = false
            }
        }

    }
    
    @IBAction func forgotUsernameButtonPressed(_ sender: UIButton) {
        forgotAction = "username"
        self.performSegue(withIdentifier: "forgotUsernamePasswordSegue", sender: nil)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        forgotAction = "password"
        self.performSegue(withIdentifier: "forgotUsernamePasswordSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logInToHomePage" && segue.destination is HomePageViewController {
            if let vc = segue.destination as? HomePageViewController {
                vc.user = self.userInfo
            }
        }
        
        if segue.identifier == "forgotUsernamePasswordSegue" && segue.destination is ForgotUsernamePasswordViewController {
            if let vc = segue.destination as? ForgotUsernamePasswordViewController {
                vc.forgot = forgotAction
            }
        }
    }

}
