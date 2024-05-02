//
//  NetworkManager.swift
//  Setvi_t
//
//  Created by Pavle on 1.5.24..
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

enum NetworkRoute {
    case users(String)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        
        switch self {
        case .users(let user):
            let userPath = user.hasPrefix("/") ? user : "/" + user
            components.path = "/users" + userPath
        }
        
        return components.url
    }
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
        guard let url = NetworkRoute.users("/\(name)").url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try jsonDecoder.decode(GithubUser.self, from: data)
            
        } catch {
            throw NetworkError.invalidData
        }
    }
}

