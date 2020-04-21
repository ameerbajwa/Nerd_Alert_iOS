//
//  Global.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/20/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation

struct Global {
    var usersQuizzes: Bool
    
    init(usersQuizzes: Bool) {
        self.usersQuizzes = usersQuizzes
    }
}

var usersQuizzesInstance = Global(usersQuizzes: false)
