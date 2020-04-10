//
//  RestAPIManager.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/2/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation


class RestAPIManager {
    let baseURL = "http://127.0.0.1:6373"
    
    func httpRequest(url: String, body: Data?, method: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let apiURL = URL(string: baseURL + url)!
        print(apiURL)
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = method
        if let safeBody = body {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = safeBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("From Web Server")
                print(error?.localizedDescription ?? "No data")
                onFailure(["Error": error?.localizedDescription ?? "No data"])
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? Data {
                print("From Web Server")
                print(responseJSON)
                onSuccess(responseJSON)
            }
        }
        
        task.resume()
    }
}

