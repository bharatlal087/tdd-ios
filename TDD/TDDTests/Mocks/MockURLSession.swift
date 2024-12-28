//
//  MockURLSession.swift
//  TDDTests
//
//  Created by Bharat Lal on 28/12/24.
//

import Foundation
@testable import TDD

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw URLError(.badServerResponse)
        }
        return (data, mockResponse ?? URLResponse())
    }
}
