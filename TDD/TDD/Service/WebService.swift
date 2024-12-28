//
//  WebService.swift
//  TDD
//
//  Created by Bharat Lal on 28/12/24.
//

import Foundation
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
