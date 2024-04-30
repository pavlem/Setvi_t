//
//  Setvi_tApp.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

@main
struct Setvi_tApp: App {
    var body: some Scene {
        WindowGroup {
            GithubUserView(viewModel: GithubUserViewModel(networkManager: NetworkManagerImpl()))
        }
    }
}
