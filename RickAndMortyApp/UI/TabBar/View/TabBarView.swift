//
//  TabBarView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import SwiftUI

struct TabBarView: View {
    /// A tabBarViewModel environment propertie
    @Environment(TabBarViewModel.self) var tabBarViewModel
    @State var charactersViewModel: CharactersViewModel = .init()
    
    @State private var selected: TabItem = .characters
    init () {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        @Bindable var tabBarViewModel = tabBarViewModel
        TabView(selection: $selected) {
            Tab(value: .characters) {
                CharactersView()
                    .environment(charactersViewModel)
            }
            Tab(value: .episodes) {
                Text("No available")
            }
            Tab(value: .locations) {
                Text("Not available")
            }
            Tab(value: .favorites) {
                FavoritesView()
                    .environment(charactersViewModel)
            }
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(selected: $selected, showTabBar: $tabBarViewModel.showTabBar)
            
        }
    }
}

#Preview {
    TabBarView()
        .environment(TabBarViewModel())
}


