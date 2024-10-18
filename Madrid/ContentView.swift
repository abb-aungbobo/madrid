//
//  ContentView.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MoviesPagingScreen()
                .ignoresSafeArea()
                .navigationTitle("Madrid")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Route.self, destination: \.destination)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(value: Route.favorites) {
                            Image(systemName: "heart")
                        }
                        
                        NavigationLink(value: Route.movieSearch) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
