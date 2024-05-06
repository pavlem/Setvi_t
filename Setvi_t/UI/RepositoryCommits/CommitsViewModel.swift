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
                let commits = try await networkManager.getCommits(forUser: user, andRepo: repo)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isLoading = false
                    self.commits = commits
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
        print(error.localizedDescription)
    }
}
