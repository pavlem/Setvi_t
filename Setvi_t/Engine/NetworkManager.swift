//
//  NetworkManager.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import Foundation

enum GithubError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

protocol NetworkManager {
    func getUser(forName name: String) async throws -> GithubUser
}

class NetworkManagerImpl: NetworkManager {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getUser(forName name: String) async throws -> GithubUser {
        guard let url = Route.users("/\(name)").url else {
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

enum Route {
    
    case users(String)
    
    var url: URL? {
        switch self {
        case .users(let user):
            return URL(string: Route.siteBaseUrl + "/users" + user)
        }
    }

    private static let siteBaseUrl = "https://api.github.com"

}
