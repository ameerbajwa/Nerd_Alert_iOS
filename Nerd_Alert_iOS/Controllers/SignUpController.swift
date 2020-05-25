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
    
    @IBOutlet weak var signUpButton: UIButton!
    
    let userService = UserService()
    var accessTokenJSON: [String: Any] = [:]
    var userInfo: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupToHideKeyboardOnTapOnView()

        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self

        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if emailTextField.text! != "" && usernameTextField.text! != "" && passwordTextField.text! != "" && passwordAgainTextField.text! != "" && passwordTextField.text! == passwordAgainTextField.text! {
            // sign up POST API call
            
            userService.registerUser(emailTextField.text!, usernameTextField.text!, passwordTextField.text!, passwordAgainTextField.text!, onSuccess: {(response) -> Void in
                print("From Swift Application : registerUser API called")
                print(response)
                print("new user created")
                
                DispatchQueue.main.async {
                    self.userService.authenticateUser(self.usernameTextField.text!, self.passwordTextField.text!, onSuccess: {(response) -> Void in
                        print("From Swift Application : authenticateUser API called")
                        print(response)
                        self.accessTokenJSON = response
                            
                        DispatchQueue.main.async {
                            self.userService.retrieveUserInfo(self.usernameTextField.text!, onSuccess: { (response) -> Void in
                                print("From Swift Application : retrieveUserInfo API called")
                                print(response)

                                self.userInfo = User(json: response)

                                if let accessToken = self.accessTokenJSON["access_token"] as? String {
                                    self.userInfo?.accessToken = accessToken
                                } else {
                                    print("couldn't pass accessToken value to userInfo struct")
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
                                    }
                                } else {
                                    print("userInfo class has not been properly populated")
                                }

                            }) { (error) -> Void in
                                print("From Swift Application : retrieveUserInfo API called")
                                print(error)
                            }
                        }

                    },
                        onFailure: { (error) -> Void in
                           print("From Swift Application : authenticateUser API called")
                           print(error)
                        }
                    )
                }
                
            },
                onFailure: { (error) -> Void in
                   print("From Swift Application : registerUser API called")
                   print(error)
            })
            
            //userInfo = userService.retrieveUserInfo()
//            self.performSegue(withIdentifier: "signUpToHomePage", sender: self)
        } else {
            // send error message that you need to fill all the textfields
        }
    }
    
//  MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "signUpToHomePage" && segue.destination is HomePageViewController {
            let destinationRVC = segue.destination as! HomePageViewController
            destinationRVC.user = userInfo
        }
    }

}
