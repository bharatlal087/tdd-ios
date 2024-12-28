//
//  ContentView.swift
//  TDD
//
//  Created by Bharat Lal on 28/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.repositories) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.title)
                    
                    if let description = repo.description {
                        Text(description)
                            .font(.footnote)
                            .foregroundStyle(Color.secondary)
                    }
                }
            }
            .padding(.vertical)
            .listStyle(.plain)
            .navigationTitle("Repositories")
        }
    }
}

#Preview {
    ContentView()
}
