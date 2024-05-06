//
//  Setvi_tApp.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

@main
struct Setvi_tApp: App {
    
    private let networkManager: NetworkManager = NetworkManagerImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                UserView(viewModel: UserViewModel(networkManager: networkManager))
            }
        }
    }
}
