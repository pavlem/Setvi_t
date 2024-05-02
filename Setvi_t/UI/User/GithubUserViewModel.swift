//
//  GithubUserViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import SwiftUI

class GithubUserViewModel: ObservableObject {
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    var isNotEmptyScreen: Bool { return login.count > 0 }
    var login: String { user.login }
    var avatarUrl: String { user.avatarUrl ?? "" }
    var bio: String { user.bio ?? "No Bio" }
    var company: String { user.company ?? "No company"}
    
    var navigationTitle: String { "GithubUser".localized }
    
    private let networkManager: NetworkManager
    @Published private var user = GithubUser()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getUser(forName name: String) {
        
        Task {
            do {
                let user = try await networkManager.getUser(forName: name)
                DispatchQueue.main.async { self.user = user }
            } catch let error as GithubError {
                handleGithubError(error)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func handleGithubError(_ error: GithubError) {
        let message: String
        
        switch error {
        case .invalidUrl:
            message = "Invalid URL provided."
        case .invalidResponse:
            message = "Invalid response from server."
        case .invalidData:
            message = "Invalid data received."
        }
        
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showErrorAlert = true
        }
    }

    private func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "An undefined error occurred."
            self.showErrorAlert = true
        }
        print(error.localizedDescription)
    }
}
