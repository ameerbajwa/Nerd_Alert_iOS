//
//  UserService.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/5/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

class UserService {
    
    let restAPIManager = RestAPIManager()
    
    
    func authenticateUser(_ username: String, _ password: String) {
        let commandURL = "/auth"
        
        let jsonBody: [String: String] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData!, method: "POST")
        
        // call /auth POST request to authenticate user from our flask web api server
    }
    
    
    func registerUser(_ email: String, _ username: String, _ password: String, _ passwordAgain: String) {
        let commandURL = "/register_user"
        if password == passwordAgain {
            
            let jsonBody: [String: String] = ["username": username,
                                              "password": password,
                                              "email": email]
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
            
            restAPIManager.httpRequest(url: commandURL, body: jsonData!, method: "POST")
        } else {
            // send error message back: passwords need to match
        }

        // call /register_user POST request to create user from our flask web api server
    }
    
}
