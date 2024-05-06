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
                let gitRepos = try await networkManager.getRepos(forName: user.login)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isLoading = false
                    self.gitRepos = gitRepos
                }
            } catch let error as NetworkError {
                handleNetworkError(error)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        let message: String
        
        switch error {
        case .invalidUrl:
            message = "Error.InvalidUrl".localized
        case .invalidResponse:
            message = "Error.InvalidResponse".localized
        case .invalidData:
            message = "Error.InvalidData".localized
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.isLoading = false
            self.errorMessage = message
            self.showErrorAlert = true
        }
    }

    private func handleError(_ error: Error) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.isLoading = false
            self.errorMessage = "Error.Undefined".localized
            self.showErrorAlert = true
        }
    }
}
