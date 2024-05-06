//
//  User.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarUrl: String?
    let bio: String?
    let company: String?
}

extension User {
    init() {
        self.login = ""
        self.avatarUrl = ""
        self.bio = ""
        self.company = ""
    }
}
