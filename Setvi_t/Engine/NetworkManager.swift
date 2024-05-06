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
    case repos(String)
    case commits(String, String)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        
        switch self {
        case .users(let user):
            let userPath = "/" + user
            components.path = "/users" + userPath
        case .repos(let user):
            let userPath = "/" + user + "/repos"
            components.path = "/users" + userPath
        case .commits(let user, let repos):
            let userPath = "/" + user + "/" + repos + "/commits"
            components.path = "/repos" + userPath
        }
        
        return components.url
    }
}

protocol NetworkManager {
    func getUser(forName name: String) async throws -> User
    func getRepos(forName name: String) async throws -> [Repository] 
    func getCommits(forUser user: String, andRepo repo: String) async throws -> [Commit]
}

class NetworkManagerImpl: NetworkManager {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getUser(forName name: String) async throws -> User {
        guard let url = NetworkRoute.users("\(name)").url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try jsonDecoder.decode(User.self, from: data)
            
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func getRepos(forName name: String) async throws -> [Repository] {
        guard let url = NetworkRoute.repos("\(name)").url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try jsonDecoder.decode([Repository].self, from: data)
            
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func getCommits(forUser user: String, andRepo repo: String) async throws -> [Commit] {
        guard let url = NetworkRoute.commits(user, repo).url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try jsonDecoder.decode([Commit].self, from: data)
            
        } catch {
            throw NetworkError.invalidData
        }
    }
}

