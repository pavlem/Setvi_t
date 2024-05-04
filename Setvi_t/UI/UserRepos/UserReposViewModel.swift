//
//  UserReposViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 4.5.24..
//

import Foundation

class UserReposViewModel: ObservableObject {
    
//    let userName: String
    private var user = GithubUser()

    init(user: GithubUser) {
        self.user = user
    }
    
    var userName: String {
        user.login
    }
}
