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
    
    func authenticateUser(_ username: String, _ password: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping ([String: Any]) -> Void ) {
        let commandURL = "/auth"
        
        let jsonBody: [String: String] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: jsonData!, method: "POST",
                onSuccess: {response -> Void in
                    onSuccess(response)
                },
                onFailure: { repsonse -> Void in
                    onFailure(repsonse)
                })
//        retrieveUserInfo(username)
        
        // call /auth POST request to authenticate user from our flask web api server
    }
    
    func retrieveUserInfo(_ username: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/user_info/\(username)"
        
//        let jsonBody: [String: String] = ["username": username]
//        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        restAPIManager.httpRequest(url: commandURL, body: nil, method: "GET",                                   onSuccess: {response -> Void in
                  onSuccess(response)
              },
              onFailure: { repsonse -> Void in
                  onFailure(repsonse)
              })
    }
    
    
    func registerUser(_ email: String, _ username: String, _ password: String, _ passwordAgain: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let commandURL = "/register_user"
        if password == passwordAgain {
            
            let jsonBody: [String: String] = ["username": username,
                                              "password": password,
                                              "email": email]
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
            
            restAPIManager.httpRequest(url: commandURL, body: jsonData!, method: "POST",
                onSuccess: {response -> Void in
                    onSuccess(response)
                },
                onFailure: { repsonse -> Void in
                    onFailure(repsonse)
                })
        } else {
            // send error message back: passwords need to match
        }

        // call /register_user POST request to create user from our flask web api server
    }
    
    
    func parseRetrieveUserInfoResponse(_ body: [String: Any], _ accessToken: String?) -> User {
        let userInfo = User(id: body["user_id"] as! Int, username: body["username"] as! String, email: body["email"] as! String, password: body["password"] as! String, dateCreated: body["dateCreated"] as! Date, lastLogin: body["lastLogin"] as! Date, accessToken: accessToken!)
        return userInfo
    }
    
}
