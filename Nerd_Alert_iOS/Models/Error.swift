//
//  Error.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/3/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct Error: Decodable {
    var error_message: String
    
     init(json: [String: Any]) {
        error_message = json["error"] as? String ?? "BLANK"
    }
}
