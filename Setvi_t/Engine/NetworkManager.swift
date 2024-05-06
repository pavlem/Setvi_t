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
            components.path = "/users/\(user)"
        case .repos(let user):
            components.path = "/users/\(user)/repos"
        case .commits(let user, let repo):
            components.path = "/repos/\(user)/\(repo)/commits"
        }
        
        return components.url
    }
}

protocol NetworkManager {
    func getUser(forName name: String) async throws -> User
    func getRepositories(forUser user: String) async throws -> [Repository]
    func getCommits(forUser user: String, andRepository repository: String) async throws -> [Commit] 
}

class NetworkManagerImpl: NetworkManager {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private func requestData<T: Decodable>(from url: URL?) async throws -> T {
        guard let url = url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func getUser(forName name: String) async throws -> User {
        return try await requestData(from: NetworkRoute.users(name).url)
    }
    
    func getRepositories(forUser name: String) async throws -> [Repository] {
        return try await requestData(from: NetworkRoute.repos(name).url)
    }
    
    func getCommits(forUser user: String, andRepository repository: String) async throws -> [Commit] {
        return try await requestData(from: NetworkRoute.commits(user, repository).url)
    }
}

