//
//  MoviesPagingScreen.swift
//  Madrid
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import ComposableArchitecture
import SwiftUI
import UIKit

struct MoviesPagingScreen: UIViewControllerRepresentable {
    typealias UIViewControllerType = MoviesPagingViewController
    
    func makeUIViewController(context: Context) -> MoviesPagingViewController {
        let viewControllers = MoviesType.allCases.map { type in
            let store: StoreOf<MoviesReducer> = Store(initialState: MoviesReducer.State(movieType: type)) {
                MoviesReducer()
            }
            let view = MoviesScreen(store: store)
            let viewController = UIHostingController(rootView: view)
            viewController.title = type.title
            return viewController
        }
        let viewController = MoviesPagingViewController(viewControllers: viewControllers)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MoviesPagingViewController, context: Context) {
        
    }
}

#Preview {
    NavigationStack {
        MoviesPagingScreen()
            .ignoresSafeArea()
            .navigationTitle("Madrid")
            .navigationBarTitleDisplayMode(.inline)
    }
}
