//
//  UserReposViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 4.5.24..
//

import Foundation

class RepositoriesViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var gitRepos: [Repository] = [Repository]()
    @Published var showErrorAlert = false
    @Published var errorMessage = ""

    let networkManager: NetworkManager
    private var user = User()
    
    var userName: String {
        user.login
    }
    
    var title: String { user.login }
    
    init(user: User, networkManager: NetworkManager) {
        self.user = user
        self.networkManager = networkManager
        
        fetchRepos()
    }
    
    private func fetchRepos() {
        self.isLoading = true
        
        Task {
            do {
                let gitRepos = try await networkManager.getRepositories(forUser: user.login)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isLoading = false
                    self.gitRepos = gitRepos
                }
            } catch {
                handle(error: error)
            }
        }
    }
    
    private func handle(error: Error) {
        let message: String
        
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidUrl:
                message = "Error.InvalidUrl".localized
            case .invalidResponse:
                message = "Error.InvalidRepositories".localized
            case .invalidData:
                message = "Error.InvalidData".localized
            }
        } else {
            message = "Error.Undefined".localized
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = message
            self.showErrorAlert = true
        }
    }
}
