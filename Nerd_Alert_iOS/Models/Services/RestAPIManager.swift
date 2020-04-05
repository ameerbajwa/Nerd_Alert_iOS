//
//  RestAPIManager.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/2/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation


class RestAPIManager {
    let baseURL = "http://127.0.0.1/6373"
    
    func httpRequest(url: String, body: Data, method: String) {
        let apiURL = URL(string: baseURL + url)!
        print(apiURL)
        
        var postRequest = URLRequest(url: apiURL)
        postRequest.httpMethod = method
        postRequest.httpBody = body
        
        let task = URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
    }
}

