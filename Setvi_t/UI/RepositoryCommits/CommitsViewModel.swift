//
//  CommitsViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import SwiftUI

class CommitsViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var commits: [Commit] = [Commit]()
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    let networkManager: NetworkManager
    var user: String
    var repo: String

    var title: String { repo }
    
    init(user: String, repo: String, networkManager: NetworkManager) {
        self.user = user
        self.repo = repo
        self.networkManager = networkManager
        
        fetchCommits()
    }
    
    private func fetchCommits() {
        self.isLoading = true
        
        Task {
            do {
                let commits = try await networkManager.getCommits(forUser: user, andRepository: repo)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isLoading = false
                    self.commits = commits
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
                message = "Error.InvalidCommits".localized
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
