//
//  Quiz.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/15/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct Quiz: Decodable {
    var id: Int
    var name: String
    var source: String
    var titleOfSource: String
    var createdBy: String
    var createdBy_id: Int
    var date_created: String
    var active: Bool?
    
    init(json: [String: Any]) {
        id = json["quiz_id"] as? Int ?? 0
        name = json["quiz_name"] as? String ?? "BLANK"
        source = json["source"] as? String ?? "BLANK"
        titleOfSource = json["title_of_source"] as? String ?? "BLANK"
        createdBy = json["createdBy"] as? String ?? "BLANK"
        createdBy_id = json["createdBy_user_id"] as? Int ?? 0
        date_created = json["date_created"] as? String ?? "BLANK"
        active = json["active"] as? Bool ?? nil
    }
}
