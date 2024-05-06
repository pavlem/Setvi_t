//
//  UserDetailsViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var user = User()

    var username: String { user.login }
    var avatarUrl: String { user.avatarUrl ?? "" }
    var biography: String { user.bio ?? "NoBio".localized }
    var company: String {
        guard user.company != "" else { return "" }
        
        if let company = user.company {
            return "Company".localized + company
        } else {
            return "NoCompany".localized
        }
    }
    var navigationTitle: String { "GithubUser".localized }
    var moreDetails: String {
        guard username != "" else { return "" }
        return "MoreDetails".localized
    }
    var enterUser: String { "EnterUser".localized }

    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getUser(forName name: String) {
        
        isLoading = true
        
        Task {
            do {
                let user = try await networkManager.getUser(forName: name)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isLoading = false
                    self.user = user
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
                message = "Error.InvalidUser".localized
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
