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

enum WebServiceError: Error{
    case invalidURL
    case noData
    case parsingFailed
    case unexpectedResponse
    case networkError(Error)
}

final class RepositoryWebService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchRepositories() async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/users/bharatlal087/repos") else {
            throw WebServiceError.invalidURL
        }
        do {
            let (data,  response) = try await session.data(for: URLRequest(url: url))
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw WebServiceError.unexpectedResponse
            }
            guard !data.isEmpty else {
                throw WebServiceError.noData
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                return try decoder.decode([Repository].self, from: data)
            } catch {
                throw WebServiceError.parsingFailed
            }
        } catch {
            throw WebServiceError.networkError(error)
        }
    }
}
