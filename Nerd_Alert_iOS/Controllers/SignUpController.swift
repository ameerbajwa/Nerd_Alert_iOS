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
//    let userInfo: User
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self

        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if emailTextField.text! != "" && usernameTextField.text! != "" && passwordTextField.text! != "" && passwordAgainTextField.text! != "" {
            // sign up POST API call
            userService.registerUser(emailTextField.text!, usernameTextField.text!, passwordTextField.text!, passwordAgainTextField.text!, onSuccess: {(response) -> Void in
                print("From Swift Application")
                print(response)
            },
                onFailure: { (error) -> Void in
                   print("From Swift Application")
                   print(error)
                })
            print("user signed in")
            //userInfo = userService.retrieveUserInfo()
//            self.performSegue(withIdentifier: "signUpToHomePage", sender: self)
        } else {
            // send error message that you need to fill all the textfields
        }
    }
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "signUpToHomePage" {
//            let destinationRVC = segue.destination as! HomeViewController
//            destinationRVC.user = userInfo
//        }
//    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if emailTextField.text! != "" && usernameTextField.text! != "" && passwordTextField.text! != "" && passwordAgainTextField.text! != "" {
//            // sign up POST API call
//            textField.endEditing(true)
//            return true
//        } else {
//            // send error message that you need to fill all the textfields
//            textField.endEditing(true)
//            return false
//        }
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if emailTextField.text! != "" && usernameTextField.text! != "" && passwordTextField.text! != "" && passwordAgainTextField.text! != "" {
//            return true
//        } else {
//            // send error message: need to fill all textfields
//            return false
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        emailTextField.text! = ""
//        usernameTextField.text! = ""
//        passwordTextField.text! = ""
//        passwordAgainTextField.text! = ""
//    }

}
