//
//  SignUpController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/2/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    let userService = UserService()
    var accessTokenJSON: [String: Any] = [:]
    var userInfo: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupToHideKeyboardOnTapOnView()
        invalidLabel.textColor = UIColor.red
        invalidLabel.isHidden = true

        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self

        signUpButton.simpleButtonDesign(button: signUpButton, borderWidth: 0)
        self.view.backgroundColor = UIColor(red: 80/255, green: 93/255, blue: 159/255, alpha: 1.0)
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        invalidLabel.isHidden = true
        if emailTextField.text! != "" && usernameTextField.text! != "" && passwordTextField.text! != "" && passwordAgainTextField.text! != "" && passwordTextField.text! == passwordAgainTextField.text! {
            // sign up POST API call
            
            userService.registerUser(emailTextField.text!, usernameTextField.text!, passwordTextField.text!, passwordAgainTextField.text!, onSuccess: {(response) -> Void in
                print("registerUser API called successfully")
                print(response)
                print("new user created")
                
                DispatchQueue.main.async {
                    self.userService.authenticateUser(self.usernameTextField.text!, self.passwordTextField.text!, onSuccess: {(response) -> Void in
                        print("authenticateUser API called successfully")
                        print(response)
                        self.accessTokenJSON = response
                            
                        DispatchQueue.main.async {
                            self.userService.retrieveUserInfo(self.usernameTextField.text!, onSuccess: { (response) -> Void in
                                print("retrieveUserInfo API called successfully")
                                print(response)

                                self.userInfo = User(json: response)

                                if let accessToken = self.accessTokenJSON["access_token"] as? String {
                                    self.userInfo?.accessToken = accessToken
                                } else {
                                    print("couldn't pass accessToken value to userInfo struct")
                                    self.invalidLabel.text = "Could not authenticate username and password. Please try another combination."
                                    self.invalidLabel.isHidden = false
                                }
                                
                                print("user information obtained and ready to be segued to home page view controller")
                                print(self.userInfo!)
                                
                                if let id = self.userInfo?.id {
                                    if id > 0 {
                                        DispatchQueue.main.async {
                                            self.performSegue(withIdentifier: "signUpToHomePage", sender: self)
                                        }
                                    } else {
                                        print("user has no id, could not return any information on user")
                                        self.invalidLabel.text = "Newly created user has no id. Please use another username/password combination or ask the all-mighty creator OneBeer for assistance."
                                        self.invalidLabel.isHidden = false
                                    }
                                } else {
                                    print("userInfo class has not been properly populated")
                                    self.invalidLabel.text = "Server Error. Address the all-mighty creator OneBeer for further inquiries"
                                    self.invalidLabel.isHidden = false
                                }

                            }) { (error) -> Void in
                                print("ERROR retrieveUserInfo API called unsuccessfully")
                                print(error)
                                self.invalidLabel.text = "Server Error. Address the all-mighty creator OneBeer for further inquiries"
                                self.invalidLabel.isHidden = false
                            }
                        }

                    },
                        onFailure: { (error) -> Void in
                           print("ERROR authenticateUser API called unsuccessfully")
                           print(error)
                            self.invalidLabel.text = "Authentication of newly created user failed. Address the all-mighty creator OneBeer for further inquiries"
                            self.invalidLabel.isHidden = false
                        }
                    )
                }
                
            },
                onFailure: { (error) -> Void in
                   print("ERROR registerUser API called unsuccessfully")
                   print(error)
                    self.invalidLabel.text = "Invalid username/password. Please try another combination."
                    self.invalidLabel.isHidden = false
            })
            
            //userInfo = userService.retrieveUserInfo()
//            self.performSegue(withIdentifier: "signUpToHomePage", sender: self)
        } else {
            invalidLabel.text = "Invalid information. Make sure you fill all necessary fields to sign up please."
            invalidLabel.isHidden = false
            // send error message that you need to fill all the textfields
        }
    }
    
//  MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpToHomePage" && segue.destination is HomePageViewController {
            let destinationRVC = segue.destination as! HomePageViewController
            destinationRVC.user = userInfo
        }
    }

}
