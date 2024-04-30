//
//  GithubUserViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import SwiftUI

class GithubUserViewModel: ObservableObject {
    
    private let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    @Published private var user: GithubUser = GithubUser(login: "", avatarUrl: "", bio: "", company: "")
    @Published var errorMessage: String? = nil // To publish error messages
    
    var login: String { user.login }
    var avatarUrl: String { user.avatarUrl ?? "" }
    var bio: String { user.bio ?? "No Bio" }
    var company: String { user.company ?? "No company"}
    
    func getUser() {
        
        Task {
            do {
                let user = try await networkManager.getUser()
                
                DispatchQueue.main.async {
                    self.user = user
                }
                
            } catch GithubError.invalidUrl {
                
                DispatchQueue.main.async {
                    self.errorMessage = "invalidUrl"
                }
                
                print("GithubError.invalidUrl")
            } catch GithubError.invalidResponse {
                DispatchQueue.main.async {
                    self.errorMessage = "invalidResponse"
                }
                print("GithubError.invalidResponse")
            } catch GithubError.invalidData {
                DispatchQueue.main.async {
                    self.errorMessage = "invalidData"
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Undefined"
                }
                print("Undefined")
            }
        }
    }
}

struct GithubUser: Decodable {
    let login: String
    let avatarUrl: String?
    let bio: String?
    let company: String?
}

enum GithubError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

protocol NetworkManager {
    func getUser() async throws -> GithubUser
}

class NetworkManagerImpl: NetworkManager {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getUser() async throws -> GithubUser {
        let endpoint = "https://api.github.com/users/pavlem"
        guard let url = URL(string: endpoint) else {
            throw GithubError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GithubError.invalidResponse
        }
        
        do {
            return try jsonDecoder.decode(GithubUser.self, from: data)
            
        } catch {
            throw GithubError.invalidData
        }
    }
}
