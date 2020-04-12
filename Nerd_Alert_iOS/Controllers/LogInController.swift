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
    
    @IBOutlet weak var logInButton: UIButton!
    
    let userService = UserService()
    var accessTokenJSON: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        logInButton.layer.cornerRadius = 10
        logInButton.layer.borderWidth = 3
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        print("Log In Button Pressed")
        if usernameTextField.text != nil && passwordTextField.text != nil {
            // log in POST API CALL and user information GET API CALL
            
            userService.authenticateUser(usernameTextField.text!, passwordTextField.text!, onSuccess: {(response) -> Void in
                print("From Swift Application : authenticateUser API called")
                print(response)
                self.accessTokenJSON = response
                
                self.userService.retrieveUserInfo(self.usernameTextField.text!, onSuccess: { (response) -> Void in
                    print("From Swift Application : retrieveUserInfo API called")
                    print(response)
                    
                    var userInfo = User(json: response)

                    if let accessToken = self.accessTokenJSON["access_token"] as? String {
                        userInfo.accessToken = accessToken
                    } else {
                        print("couldn't pass accessToken value to userInfo struct")
                    }

                    print(userInfo)
                    
    //                    self.performSegue(withIdentifier: "logInToHomePage", sender: self)
    //
    //                    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //                        // Get the new view controller using segue.destination.
    //                        // Pass the selected object to the new view controller.
    //                        if segue.identifier == "logInToHomePage" {
    //                            let destinationRVC = segue.destination as! HomeViewController
    //                            destinationRVC.user = userInfo
    //                        }
    //                    }
                    
                }) { (error) -> Void in
                    print("From Swift Application : retrieveUserInfo API called")
                    print(error)
                }

            },
                onFailure: { (error) -> Void in
                   print("From Swift Application : authenticateUser API called")
                   print(error)
                }
            )
            
        } else {
            // send error message all textfields need to be filled out
            print("Need to fill out username and password textfields")
        }
    }
    
//    // MARK: - Navigation
//

    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if usernameTextField.text != nil && passwordTextField.text != nil {
//            // log in POST API CALL and user information GET API CALL
//            return true
//        } else {
//            // send error message all textfields need to be filled out
//            return false
//        }
//    }
//    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if usernameTextField.text != "" && passwordTextField.text != "" {
//            return true
//        } else {
//            // send error message: need to fill out all textfields
//            return false
//        }
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        usernameTextField.text! = ""
//        passwordTextField.text! = ""
//    }

}
