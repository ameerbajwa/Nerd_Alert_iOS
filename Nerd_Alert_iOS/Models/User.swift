//
//  User.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/2/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct User {
    var id: Int
    var username: String
    var email: String
    var password: String
    var dateCreated: Date
    var lastLogin: Date
    
    init(id: Int, username: String, email: String, password: String, dateCreated: Date, lastLogin: Date) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.dateCreated = dateCreated
        self.lastLogin = lastLogin
    }
    
}
