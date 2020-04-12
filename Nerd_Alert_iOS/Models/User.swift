//
//  User.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/2/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation
import Marshal

struct User: Decodable {

    var id: Int
    var username: String
    var email: String
    var password: String
    var dateCreated: Date?
    var lastLogin: Date?
    var accessToken: String?
    
    init(json: [String: Any]) {
        id = json["user_id"] as? Int ?? 0
        username = json["username"] as? String ?? "BLANK"
        email = json["email"] as? String ?? "BLANK"
        password = json["password"] as? String ?? "BLANK"
        dateCreated = json["date_created"] as? Date ?? nil
        lastLogin = json["last_login"] as? Date ?? nil
        accessToken = json["access_token"] as? String ?? "BLANK"
    }

}
