//
//  GithubUser.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import Foundation

struct GithubUser: Decodable {
    let login: String
    let avatarUrl: String?
    let bio: String?
    let company: String?
}

extension GithubUser {
    init() {
        self.login = ""
        self.avatarUrl = ""
        self.bio = ""
        self.company = ""
    }
}
