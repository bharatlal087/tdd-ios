//
//  WebServiceTest.swift
//  TDDTests
//
//  Created by Bharat Lal on 28/12/24.
//

import XCTest
@testable import TDD

final class WebServiceTest: XCTestCase {
    var mockSession: MockURLSession!
    var repositoryService: RepositoryWebService! // Fails here

    override func setUpWithError() throws {
        mockSession = MockURLSession()
        repositoryService = RepositoryWebService(session: mockSession) // Fails here
    }
    
    override func tearDownWithError() throws {
        mockSession = nil
        repositoryService = nil
    }
    
    func testFetchServiceSuccess() async throws {
        // Arrange
        let jsonResponse = """
        [{
        "id": 100,
        "name": "tdd-ios",
        "full_name": "tdd-ios",
        "description": "public repository for demonstrate TDD in iOS "
        }]
        """
        mockSession.mockData = jsonResponse.data(using: .utf8)
        
        // Act
        let repositories = try await repositoryService.fetchRepositories()
        
        // Assert
        XCTAssertEqual(repositories.first?.name ?? "", "tdd-ios")
        XCTAssertEqual(repositories.count, 1)
        
    }

    func testFetchServiceFail() async {
        // Arrange
        mockSession.mockError = URLError(.notConnectedToInternet)
        
        // Act & Assert
        do {
            _ = try await repositoryService.fetchRepositories()
            XCTFail("Expected an error but got success.")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
