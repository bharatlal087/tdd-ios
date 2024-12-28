//
//  ContentViewModel.swift
//  TDD
//
//  Created by Bharat Lal on 28/12/24.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    private let service = RepositoryWebService() // it should be injected from outside in real project
    
    init() {
        fetchData()
    }

    private func fetchData() {
        Task {
            do {
                repositories = try await service.fetchRepositories()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
