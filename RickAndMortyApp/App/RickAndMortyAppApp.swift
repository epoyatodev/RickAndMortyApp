//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    @State private var tabBarViewModel: TabBarViewModel = .init()
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(tabBarViewModel)
        }
    }
}
