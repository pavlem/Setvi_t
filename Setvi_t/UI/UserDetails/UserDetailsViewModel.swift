//
//  UserDetailsViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import SwiftUI

class UserDetailsViewModel: ObservableObject {
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    @Published var isFetchingUser = false
    
    var isNotEmptyScreen: Bool { return username.count > 0 }
    var username: String { user.login }
    var avatarUrl: String { user.avatarUrl ?? "" }
    var biography: String { user.bio ?? "NoBio".localized }
    var company: String {
        if let company = user.company {
            "Company".localized + company
        } else {
            "NoCompany".localized
        }
    }
    var navigationTitle: String { "GithubUser".localized }
    var moreDetails: String { "MoreDetails".localized }
    var enterUser: String { "EnterUser".localized }

    private let networkManager: NetworkManager
    @Published var user = GithubUser()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getUser(forName name: String) {
        
        isFetchingUser = true
        
        Task {
            do {
                let user = try await networkManager.getUser(forName: name)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isFetchingUser = false
                    self.user = user
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isFetchingUser = false
            self.errorMessage = message
            self.showErrorAlert = true
        }
    }

    private func handleError(_ error: Error) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isFetchingUser = false
            self.errorMessage = "Error.Undefined".localized
            self.showErrorAlert = true
        }
        print(error.localizedDescription)
    }
}
