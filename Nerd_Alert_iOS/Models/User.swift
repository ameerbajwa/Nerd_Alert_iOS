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
    
//    private enum MainKeys: String, CodingKey {
//        case id = "user_id"
//        case username
//        case email
//        case password
//        case dateCreated = "date_created"
//        case lastLogin = "last_login"
////        case accessToken = "access_token"
//    }
//
//    init(from decoder: Decoder) throws {
//
//        if let userContainer = try? decoder.container(keyedBy: MainKeys.self) {
//            self.id = try userContainer.decode(Int.self, forKey: .id)
//            self.username = try userContainer.decode(String.self, forKey: .username)
//            self.email = try userContainer.decode(String.self, forKey: .email)
//            self.password = try userContainer.decode(String.self, forKey: .password)
//            self.dateCreated = try userContainer.decode(Date.self, forKey: .dateCreated)
//            self.lastLogin = try userContainer.decode(Date.self, forKey: .lastLogin)
////            self.accessToken = try userContainer.decode(String.self, forKey: .accessToken)
//        }
//    }
    

//    init(object: MarshaledObject) throws {
//        id = try object.value(for: "user_id")
//        username = try object.value(for: "username")
//        email = try object.value(for: "email")
//        password = try object.value(for: "password")
//        dateCreated = try object.value(for: "dateCreated")
//        lastLogin = try object.value(for: "lastLogin")
//        accessToken = try object.value(for: "access_token")
//    }

//    init(id: Int, username: String, email: String, password: String, dateCreated: Date, lastLogin: Date, accessToken: String) {
//        self.id = id
//        self.username = username
//        self.email = email
//        self.password = password
//        self.dateCreated = dateCreated
//        self.lastLogin = lastLogin
//        self.accessToken = accessToken
//    }

}

//extension User: Marshaling {
//    func marshaled() -> [String: Any] {
//        return {
//            "username": username,
//            "email": email,
//            "password": password
//        }
//    }
//}
