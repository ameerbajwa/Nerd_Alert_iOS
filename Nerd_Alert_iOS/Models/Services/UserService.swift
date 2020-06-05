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
    
    func authenticateUser(_ username: String, _ password: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void ) {
        let commandURL = "/auth"
        
        let jsonBody: [String: String] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData!, method: "POST",
                onSuccess: {responseJSON -> Void in
                    onSuccess(responseJSON)
                },
                onFailure: { responseJSON -> Void in
                    onFailure(responseJSON)
                })
        
        // call /auth POST request to authenticate user from our flask web api server
    }
    
    func retrieveUserInfo(_ username: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/user_info/\(username)"
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET", onSuccess: {responseJSON -> Void in
                  onSuccess(responseJSON)
              },
              onFailure: { responseJSON -> Void in
                  onFailure(responseJSON)
              })
    }
    
    func retrieveUserForgottenInfo(email: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/user_forgotten_info/\(email)"
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET", onSuccess: {responseJSON -> Void in
                  onSuccess(responseJSON)
              },
              onFailure: { responseJSON -> Void in
                  onFailure(responseJSON)
              })
    }
    
    
    func registerUser(_ email: String, _ username: String, _ password: String, _ passwordAgain: String, onSuccess: @escaping ([String: Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/register_user"
        if password == passwordAgain {
            
            let jsonBody: [String: Any] = ["username": username,
                                              "password": password,
                                              "email": email,
                                              "admin": 0,
                                              "creator": 1]
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
            
            restAPIManager.httpRequest(url: commandURL, body: jsonData!, method: "POST",
                onSuccess: {responseJSON -> Void in
                    onSuccess(responseJSON)
                },
                onFailure: { responseJSON -> Void in
                    onFailure(responseJSON)
                })
        } else {
            // send error message back: passwords need to match
        }

        // call /register_user POST request to create user from our flask web api server
    }
    
}
