//
//  RepositoryWebService.swift
//  TDD
//
//  Created by Bharat Lal on 28/12/24.
//

import Foundation
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}


final class RepositoryWebService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchRepositories() async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/users/bharatlal087/repos") else {
            throw URLError(.badURL)
        }
        
        let (data,  _) = try await session.data(for: URLRequest(url: url))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Repository].self, from: data)
    }
}
