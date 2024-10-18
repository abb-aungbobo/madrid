//
//  MadridApp.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct MadridApp: App {
    
    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBackground
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(.brown)
        }
    }
}
